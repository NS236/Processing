class Ball {
  PVector pos;
  float r;
  PVector vel;
  
  Ball() {
    pos = new PVector(random(size), random(size), random(size));
    r = random(10, 50);
    vel = PVector.random3D();
    vel.setMag(random(0.1, 1));
  }
  
  void update() {
    pos.add(vel);
    
    if(pos.x <= 0) {
      vel.x *= -1;
      pos.x = 0;
    }
    if(pos.x >= size) {
      vel.x *= -1;
      pos.x = size;
    }
    if(pos.y <= 0) {
      vel.y *= -1;
      pos.y = 0;
    }
    if(pos.y >= size) {
      vel.y *= -1;
      pos.y = size;
    }
    if(pos.z <= 0) {
      vel.z *= -1;
      pos.z = 0;
    }
    if(pos.z >= size) {
      vel.z *= -1;
      pos.z = size;
    }
  }
}
