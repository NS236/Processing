import processing.pdf.*;
//hitomezashi

int rows;
int cols;

float maxD;

float xscl;
float yscl;

int[] hpattern;
int[] vpattern;

float hprob;
float vprob;

void setup() {
  size(600, 600);
  //fullScreen();
  colorMode(HSB);

  rows = height / 20;
  cols = width / 20;

  maxD = rows * rows + cols * cols;

  xscl = width / cols;
  yscl = height / rows;

  hpattern = new int[cols];
  vpattern = new int[rows];

  hprob = 0.25;
  vprob = 0.75;

  for (int i = 0; i < hpattern.length; i++) {
    if (random(1) < hprob) {
      hpattern[i] = 0;
    } else {
      hpattern[i] = 1;
    }
  }

  for (int i = 0; i < vpattern.length; i++) {
    if (random(1) < vprob) {
      vpattern[i] = 0;
    } else {
      vpattern[i] = 1;
    }
  }
}

void draw() {
  float hu = frameCount % 360;
  background(0);
  
  strokeWeight(xscl * yscl / 50);
  stroke(0);

  for (int i = 0; i < hpattern.length; i++) {
    for (int j = 0; j < rows; j++) {
      if (j % 2 == hpattern[i]) {
        stroke(map(i*i + j*j, 0, maxD, hu, hu * 0.5), 90, 240);
        line(i * xscl, j * yscl, i * xscl, (j+1) * yscl);
      }
    }
  }

  for (int j = 0; j < vpattern.length; j++) {
    for (int i = 0; i < cols; i++) {
      if (i % 2 == vpattern[j]) {
        stroke(map(i*i + j*j, 0, maxD, hu, hu * 0.5), 90, 240);
        line(i * xscl, j * yscl, (i+1) * xscl, j * yscl);
      }
    }
  }
}
