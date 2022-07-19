int speed = 2;
class Seed {
  PVector pos;
  PVector vel;

  Seed(float x, float y) {
    pos = new PVector(x, y);
    vel = PVector.random2D();
    vel.setMag(speed);
  };
  
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
    stroke(0, 0, 0);
    strokeWeight(5);
    point(pos.x, pos.y);
  };
}
