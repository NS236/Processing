PImage drawSky() {
  background(0);
  for(int i = 0; i < height; i++) {
    float r = map(i, 0, height, 30, 50);
    float g = map(i, 0, height, 10, 50);
    float b = map(i, 0, height, 70, 50);
    noStroke();
    fill(r, g, b);
    rect(0, i, width, 1);
  }
  
  return get();
}
