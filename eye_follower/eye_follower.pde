Eye[] myCircleArray = new Eye[300];

void setup() {
  fullScreen();
  noCursor();
  ellipseMode(RADIUS);
  colorMode( HSB );
  noStroke();
  for(int i=0; i<myCircleArray.length; i++) {
  myCircleArray[i] = new Eye(int( random(3000)),int(random(2000)), int (random(20,80)));

}
}

void draw() {
  background(102);
  for(int i=0; i<myCircleArray.length; i++) {
  myCircleArray[i].update(mouseX,mouseY);
  myCircleArray[i].display();
  }
  
}

class Eye {
  //DATA
  float x;
  float y;
  int size;
  float angle = 0.0;
  Eye( int new_x, int new_y, int new_size ) {
  x = new_x;
  y = new_y;
  size = new_size;

}

void update(int mouse_x, int mouse_y) {
  angle = atan2(mouse_y - y, mouse_x - x);
}


void display() {
pushMatrix(); 
translate(x, y); 
fill(255);
ellipse(0, 0, size, size);
rotate(angle); 
fill(60,120,200);
ellipse(size/4, 0, size/2, size/2); 
fill(0);
ellipse(size/4, 0, size/3, size/3); 
popMatrix();
}
}
