int totalBalls = 5;
Ball[] balls = new Ball[totalBalls];
void setup() {
  size(600, 600);
  pixelDensity(1);
  
  for(int i = 0; i < totalBalls; i++) {
    balls[i] = new Ball();
  }
};

float distance(float x1, float y1, float x2, float y2) {
  return abs(x1 - x2) + abs(y1 - y2);
}

void draw() {
  background(0);
  
  loadPixels();
  for(var x = 0; x < width; x++) {
    for(var y = 0; y < width; y++) {
      int i = x + y * width;
      float sum = 0;
      for(Ball b : balls) {
        sum += 250 * b.r / distance(x, y, b.pos.x, b.pos.y);
      }
      pixels[i] = color(sum);
    }
  }
  updatePixels();
  
  for(Ball b : balls) {
    b.update();
    //b.show();
  }
};
