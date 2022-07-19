class Rocket {
  PVector pos;
  PVector dest;
  PVector vel;
  boolean dead;
  Rocket() {
    pos = new PVector(random(width), height);
    dest = new PVector(random(width), random(height * 0.65));
    vel = PVector.sub(dest, pos);
    vel.setMag(random(5, 10));
    
    dead = false;
  }
  
  void update() {
    pos.add(vel);

    if(pos.y <= dest.y) {
      explode();
    }
  }
  
  void explode() {
    float hu = random(360);
    float r = random(50, 100);
    for(float i = 0; i < TWO_PI; i += PI / 10) {
      float dx = pos.x + cos(i) * r;
      float dy = pos.y + sin(i) * r;
      sparks.add(new Spark(pos.copy(), new PVector(dx, dy), hu, true));
    }
    
    dead = true;
  }
  
  void show() {
    stroke(0, 0, 255);
    strokeWeight(2);
    point(pos.x, pos.y);
  }
}
