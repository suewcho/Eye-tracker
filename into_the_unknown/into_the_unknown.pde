ParticleSystem ps;
import processing.sound.*;

SoundFile file;


void setup() {
  fullScreen();
  noCursor();
  ps = new ParticleSystem(new PVector(width, height));
  for (int i=0; i<2000; i++)
  {
    ps.addParticle();
  }
  file = new SoundFile(this, "C5.mp3");
}


void draw() {
  background(0);
  float r1 = mouseX;
  ps.move_away_from(mouseX, mouseY);
  
  ps.run();
    if (r1<width*3/37){
     file = new SoundFile(this, "C5.mp3");
    //file.playFor(file.duration());
  }else if (r1<width*5/37){
    file = new SoundFile(this, "G4.mp3");
    //file.play();
  }else if (r1<width*18/37){
    file = new SoundFile(this, "G5.mp3");
    //file.play();
  }
  else if (r1<width*21/37){
    file = new SoundFile(this, "C5.mp3");
    //file.play();
  }else if (r1<width*23/37){
    file = new SoundFile(this, "G4.mp3");
    //file.play();
  }else if (r1<width*26/37){
    file = new SoundFile(this, "A5.mp3");
    //file.play();
  }else if (r1<width){
    file = new SoundFile(this, "G5.mp3");
    //file.play();
  }
  file.play();
  delay(30);
  
}

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;

  ParticleSystem(PVector position) {
    origin = position.copy();
    particles = new ArrayList<Particle>();
  }

  void addParticle() {
    particles.add(new Particle(origin));
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
//      if (p.isDead()) {
        //    particles.remove(i);
//      }
    }
  }
  void move_away_from( float x, float y){
    for(Particle p : particles){
      float d = dist(x,y,p.position.x, p.position.y);
      if( d < 200 ){ // Only move points near click.
        p.velocity.x += map(d,0,200,0.5,0.1)*(p.position.x - x);
        p.velocity.y += map(d,0,200,0.5,0.1)*(p.position.y - y);
      }
    }
  }

}


class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  PVector home;

  Particle(PVector l) {
    acceleration = new PVector(0, 0);
    velocity = new PVector(0,0);//random(-0.0001, 0.00001), random(-0.001, 0.0001));

    l=new PVector(random(0, width), random(0, height));
    position = l.copy();
    home = position.copy();
    lifespan = 255.0;
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    acceleration.x = -0.01*(position.x - home.x);
    acceleration.y = -0.01*(position.y - home.y);
    velocity.add(acceleration);
    velocity.mult(0.9);
    position.add(velocity);
    //   lifespan -= 1.0;
  }

  // Method to display
  void display() {
    noStroke();//stroke(255, lifespan);
    //fill(255, lifespan);
    float notblue = map(abs(velocity.mag()),0,50,255,0); 
    fill(notblue,notblue,255);
    ellipse(position.x, position.y, 8, 8);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
