class Seed {
  PVector pos;

  Seed(float x, float y) {
    pos = new PVector(x, y);
  };
  
  void show() {
    stroke(0, 0, 0);
    strokeWeight(5);
    point(pos.x, pos.y);
  };
}
