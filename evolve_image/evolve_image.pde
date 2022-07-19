int w;
int h;

int maxGens;

PImage targetImage;
int tw;
int th;

Pop population;

Img leastImg;
Img mostImg;

void setup() {
  size(800, 800);
  frameRate(60);
  w = 320;
  h = 240;
  maxGens = 10000;

  targetImage = loadImage("tim-berners-lee.jpg");
  tw = targetImage.width;
  th = targetImage.height;

  background(255);
  fill(0);
  textFont(createFont("Trebuchet MS", 40));
  textAlign(CENTER, CENTER);
  text("Evolving Tim Berners-Lee", width / 2, 50);
  textSize(20);
  text("OG", 50 + w / 2, 100 + h + 15);
  text("Evolution", 50 + w / 2, 450 + h + 15);
  textAlign(LEFT, TOP);
  image(targetImage, 50, 100, w, h);
  
  population = new Pop();
}

void drawImage(PImage img, float x, float y, float w, float h) {
  image(img, x, y, w, h);
}

void draw() {
  population.select();
  population.reproduce();
  population.show();
  population.stats();
  if (population.genCount >= maxGens) {
    noLoop();
  }
};
