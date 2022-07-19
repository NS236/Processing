float time = 0;
PImage drawClouds() {
  background(0, 0);
  float scl = 0.02;
  loadPixels();
  for(int x = 0; x < width; x++) {
    for(int y = 0; y < height / 2; y++) {
      int index = x + y * width;
      float val = noise(x * scl, y * scl, time * 2);
      
      float h = 0;
      if(y < height / 6 + map(val, 0, 1, -100, 100)) {
        h = 5;
      }
      
      color col;
      if(val > 0.5) {
        col = color(map(val, 0, 1, 90, 135) + h);
      } else {
        col = color(map(val, 0, 1, 90, 130) + h);
      }

      pixels[index] = col;
    }
  }
  updatePixels();
  
  PImage cloud = get();
  
  background(0);
  noStroke();
  fill(255);
  beginShape();
  vertex(width, 0);
  vertex(0, 0);
  vertex(0, height * 0.3);
  for(float i = 0; i < width; i++) {
    float val = noise(i / 250, time);
    
    vertex(i, height * 0.3 + map(val, 0, 1, -height * 0.15, height * 0.15));
  }
  endShape(CLOSE);
  filter(BLUR, 3);
  time += 0.001;
  
  cloud.mask(get());
  return cloud;
}
