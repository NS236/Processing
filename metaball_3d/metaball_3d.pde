import peasy.*;

PeasyCam cam;

int totalBalls = 4;
int size = 25;
Ball[] balls = new Ball[totalBalls];
int px[][][] = new int[size][size][size];
void setup() {
  size(600, 600, P3D);
  pixelDensity(1);
  lights();
  cam = new PeasyCam(this, size * 1.5);
  perspective(PI/3.0, width/height, 0.1, 500);

  for (int i = 0; i < totalBalls; i++) {
    balls[i] = new Ball();
  }

  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++) {
      for (int k = 0; k < size; k++) {
        px[i][j][k] = 0;
      }
    }
  }
};

float distance(float x1, float y1, float z1, float x2, float y2, float z2) {
  return dist(x1, y1, z1, x2, y2, z2);
}

void cube(float x, float y, float z, float s) {
  pushMatrix();
  translate(x, y, z);
  box(s);
  popMatrix();
}

void draw() {
  background(0);
  rotateX(PI / 4);
  rotateZ(PI / 6);
  translate(-size / 2, -size / 2, -size / 2);

  noStroke();

  for (int x = 0; x < size; x++) {
    for (int y = 0; y < size; y++) {
      for (int z = 0; z < size; z++) {
        float sum = 0;
        for (Ball b : balls) {
          sum += pow(0.35 * b.r / distance(x, y, z, b.pos.x, b.pos.y, b.pos.z), 3);
        }
        px[x][y][z] = color(sum);
        fill(255, sum);
        cube(x, y, z, 1);
      }
    }
  }

  for (Ball b : balls) {
    b.update();
  }
};
