size(800, 800);
colorMode(HSB);

color[] palette = new color[201];

for(int i = 0; i < palette.length; i++) {
  float hue = map(i, 0, palette.length, 160, 100);
  float sat = map(i, 0, palette.length, 200, 0);
  float bri = map(i, 0, palette.length, 150, 255);
  palette[i] = color(hue, sat, bri);
}
palette[palette.length - 1] = color(0);

loadPixels();
for (int i = 0; i < width; i++) {
  for (int j = 0; j < height; j++) {
    float x0 = map(i, 0, width, -2.00, 0.47);
    float y0 = map(j, 0, height, -1.12, 1.12);
    float x = 0.0;
    float y = 0.0;
    int iteration = 0;
    int max_iteration = 200;
    while (x*x + y*y <= 2*2 && iteration < max_iteration) {
      float xtemp = x*x - y*y + x0;
      y = 2*x*y + y0;
      x = xtemp;
      iteration++;
    }
    int index = i + j * width;
    pixels[index] = palette[iteration];
  }
}
updatePixels();
