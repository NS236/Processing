PImage img1;
PImage img2;
PImage new_img;

float p = 0;

void setup() {
  size(600, 400);
  pixelDensity(1);
  
  img1 = loadImage("red3.jpg");
  img2 = loadImage("org3.jpg");
  
  new_img = img1.copy();
}

void draw() {
  new_img.loadPixels();
  img1.loadPixels();
  img2.loadPixels();
  for(int i = 0; i < new_img.pixels.length; i++) {
    new_img.pixels[i] = lerpColor(img1.pixels[i], img2.pixels[i], p);
  }
  new_img.updatePixels();
  image(new_img, 0, 0);
  
  image(img1, 400, 0, 200, 200);
  image(img2, 400, 200, 200, 200);
  
  p += 0.01;
  if(p > 1.5) {
    p = 0;
  }
}
