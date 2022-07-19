PImage clouds;
PImage sky;

void setup() {
  size(600, 600);
  
  sky = drawSky();
  
  clouds = drawClouds();
  image(clouds, 0, 0);
}

void draw() {
  clouds = drawClouds();
  
  image(sky, 0, 0);
  image(clouds, 0, 0);
}
