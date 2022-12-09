import cv2
import mediapipe as mp
import pyautogui
import pydirectinput
import keyboard

cam = cv2.VideoCapture(0)
face_mesh = mp.solutions.face_mesh.FaceMesh(refine_landmarks = True)
screen_w, screen_h = pydirectinput.size()
on = False

while True:
	try:
		if keyboard.is_pressed('q'):
			on = False
		elif keyboard.is_pressed('s'):
			on = True
	except:
		pass

	_, frame = cam.read()
	frame = cv2.flip(frame,1)
	rgb_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
	output = face_mesh.process(rgb_frame)
	landmark_points = output.multi_face_landmarks
	frame_h, frame_w, _ = frame.shape
	if landmark_points:
		landmarks = landmark_points[0].landmark

		for id, landmark in enumerate(landmarks[474:478]):
			x = int(landmark.x * frame_w)
			y = int(landmark.y * frame_h)
			cv2.circle(frame, (x,y), 3, (0,255,0))

			if id == 1 and on:
				screen_x = int(screen_w / frame_w * x)
				screen_y = int(screen_h / frame_h * y)
				pydirectinput.moveTo(screen_x,screen_y)
				left = [landmarks[145], landmarks[159]]
				right = [landmarks[374],landmarks[386]]

				for landmark in left:
					x = int(landmark.x * frame_w)
					y = int(landmark.y * frame_h)
					cv2.circle(frame, (x, y), 3, (0, 255, 255))

				if (left[0].y - left[1].y) < 0.004 and (right[0].y - right[1].y) > 0.006:
					pydirectinput.click()
					pyautogui.sleep(0.5)

				if (right[0].y - right[1].y) < 0.004 and (left[0].y - left[1].y) > 0.006:
					pydirectinput.click(button='right')
					pyautogui.sleep(0.5)
		

	cv2.imshow('eye controlled Mouse', frame)
	cv2.waitKey(1)

