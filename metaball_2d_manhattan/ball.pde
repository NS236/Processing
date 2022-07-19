float speed = 5;
class Ball {
  PVector pos;
  float r;
  PVector vel;
  
  Ball() {
    pos = new PVector(random(width), random(height));
    r = random(10, 50);
    vel = PVector.random2D();
    vel.setMag(speed);
  }
  
  void update() {
    pos.add(vel);
    
    if(pos.x <= 0) {
      vel.x *= -1;
      pos.x = 0;
    }
    if(pos.x >= width) {
      vel.x *= -1;
      pos.x = width;
    }
    if(pos.y <= 0) {
      vel.y *= -1;
      pos.y = 0;
    }
    if(pos.y >= height) {
      vel.y *= -1;
      pos.y = height;
    }
  }
  
  void show() {
    noFill();
    stroke(255);
    strokeWeight(2);
    ellipse(pos.x, pos.y, r * 2, r * 2);
  }
}
