//import processing.pdf.*;
int[][] grid;

void setup() {
  size(600, 600);
  colorMode(RGB, 1);
  //beginRecord(PDF, "rule90.pdf");
  grid = new int[height][width];
  //grid[0][int(width/2)] = 1;
  for(int i = 0; i < grid[0].length; i++) {
    grid[0][i] = round(random(1));
  }
}

boolean xor(int a, int b) {
  return a + b == 1;
}

void draw() {
  
  loadPixels();
  for(int i = 0; i < width; i++) {
    for(int j = 0; j < height; j++) {
      int index = i + j * width;
      pixels[index] = color(grid[j][i]);
    }
  }
  updatePixels();
  
  for(int j = height - 1; j > 0; j--) {
    grid[j] = grid[j - 1].clone();
  }
  
  int[] next = grid[0].clone();
  
  next[0] = int(xor(grid[0][1], grid[0][grid.length - 1]));
  
  for(int i = 1; i < width - 1; i++) {
    next[i] = int(xor(grid[0][i-1], grid[0][i+1]));
  }
  
  next[grid.length - 1] = int(xor(grid[0][grid.length - 2], grid[0][0]));
  
  grid[0] = next;
  
  if(frameCount == height) {
    //image(get(), 0, 0);
    //endRecord();
    noLoop();
  }
}
