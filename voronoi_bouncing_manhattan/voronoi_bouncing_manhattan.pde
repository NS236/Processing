int totalSeeds = 50;
Seed[] seeds = new Seed[totalSeeds];
int[] cells;


void setup() {
  size(600, 600);
  pixelDensity(1);
  colorMode(HSB, 360, 100, 100);
  for(int i = 0; i < totalSeeds; i++) {
    seeds[i] = new Seed(random(width), random(height));
  }
  loadPixels();
  cells = new int[pixels.length];
  updatePixels();
};

void draw() {
  background(0, 0, 0);
  voronoi();
  for(Seed s : seeds) {
    s.update();
    s.show();
  }
};

float distance(float x1, float y1, float x2, float y2) {
  return abs(x1 - x2) + abs(y1 - y2);
};

void voronoi() {
  for(int x = 0; x < width; x++) {
    for(int y = 0; y < height; y++) {
      int i = x + y * width;
      int nearest = 0;
      for(int j = 0; j < totalSeeds; j++) {
        Seed s = seeds[j];
        Seed near = seeds[nearest];
        if(distance(x, y, s.pos.x, s.pos.y) < distance(x, y, near.pos.x, near.pos.y)) {
          nearest = j;
        }
      }
      
      cells[i] = nearest;
    }
  }
  loadPixels();
  for(int x = 0; x < width; x++) {
    for(int y = 0; y < height; y++) {
      int i = x + y * width;
      float hu = map(cells[i] % (totalSeeds / 2), 0, totalSeeds / 2, 0, 360);
      float sat = map(cells[i], 0, totalSeeds, 100, 20);
      float brite = map(cells[i], 0, totalSeeds, 100, 20);
      pixels[i] = color(hu, 75, 100);
    }
  }
  updatePixels();
};
