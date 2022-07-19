import processing.video.*;

Capture cam;

void setup() {
  size(640, 480);

  cam = new Capture(this, 640, 480, "pipeline:autovideosrc");
  cam.start();       
}

void captureEvent(Capture cam) {
  cam.read();
}

void draw() {
  translate(width, 0);
  scale(-1, 1);
  image(cam, 0, 0);
  filter(POSTERIZE, 4);
}
