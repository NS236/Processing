class Spark {
  PVector start;
  PVector pos;
  PVector dest;
  float p;
  float hu;
  boolean dead;
  boolean reproduce;
  
  Spark(PVector st, PVector dt, float h, boolean children, float b) {
    start = st;
    pos = start.copy();
    dest = dt;
    p = b;
    hu = h;
    dead = false;
    reproduce = children;
  }
  
  Spark(PVector st, PVector dt, float h, boolean children) {
    start = st;
    pos = start.copy();
    dest = dt;
    p = 0;
    hu = h;
    dead = false;
    reproduce = children;
  }
  
  void update() {
    pos = PVector.lerp(start, dest, p);
    p += 0.05;
    
    if(reproduce && frameCount % 3 == round(random(2))) {
      sparks.add(new Spark(pos.copy(), pos.copy().add(PVector.random2D()), hu, false, p));
    }
    
    if(p > 3) {
      dead = true;
    }
  }
  
  void show() {
    stroke(hu + random(-50, 50), 255, 255, map(p, 0, 3.5, 255, 0));
    strokeWeight(4);
    point(pos.x, pos.y);
  }
}
