import processing.pdf.*;

int[][] sandpile;

int[][] newpile;

color[] cols;

PGraphics canv;

int w;
int h;

int max;

int scl;

boolean edges;

void setup() {
  size(1200, 1200, PDF, "sandpile3.pdf");
  
  w = 1200;
  h = 1200;
  
  if(w > h) {
    scl = width / w;
  } else {
    scl = height / h;
  }
  
  sandpile = new int[w][h];
  
  newpile = clone(sandpile);
  
  max = 3;
  
  cols = new color[]{#fff8f0, #284b63, #f8d822, #ec4067, #777777, #000000};
  
  canv = createGraphics(width, height);
  
  edges = false;
}

int[][] clone(int[][] arr) {
  int cols = arr.length;
  int rows = arr[0].length;
  int[][] newArr = new int[cols][rows];
  
  for(int i = 0; i < cols; i++) {
    newArr[i] = arr[i].clone();
  }
  
  return newArr;
}

boolean equal(int[][] arr1, int[][] arr2) {
  int cols = arr1.length;
  int rows = arr1[0].length;
  
  for(int i = 0; i < cols; i++) {
    for(int j = 0; j < rows; j++) {
      if(arr1[i][j] != arr2[i][j]) {
        return false;
      }
    }
  }
  
  return true;
}

void topple() {
  for(int i = 0; i < w; i++) {
    for(int j = 0; j < h; j++) {
      if(sandpile[i][j] > max) {
        newpile[i][j] -= 4;
        if(i > 0) {
          newpile[i-1][j] += 1;
        }
        if(i < w - 1) {
          newpile[i+1][j] += 1;
        }
        if(j > 0) {
          newpile[i][j-1] += 1;
        }
        if(j < h - 1) {
          newpile[i][j+1] += 1;
        }
        
        if(i < 20 || i > w - 20 || j < 20 || j > h - 20) {
          edges = true;
        }
      }
    }
  }
}

PImage show() {
  canv.noSmooth();
  canv.beginDraw();
  canv.loadPixels();
  for(int i = 0; i < w; i++) {
    for(int j = 0; j < h; j++) {
      int index = j + i * width;
      int colIndex = sandpile[i][j];
      if(colIndex < cols.length) {
        canv.pixels[index] = cols[colIndex];
      } else {
        canv.pixels[index] = 0;
      }
    }
  }
  canv.updatePixels();
  
  PImage img = canv.get(0, 0, w, h);
  
  canv.endDraw();
  
  return img;
}

void printPile() {
  for(int[] col : sandpile) {
    printArray(col);
  }
}

void draw() {
  while(!edges) {
    while(true) {
      
      topple();
      
      if(equal(sandpile, newpile)) {
        //print("FINISHED\n");
        break;
      } else {
        sandpile = clone(newpile);
      }
    }
    
    //add();
    
    newpile[int(w/2)][int(h/2)] += int(pow(2, 12));
  }
  
  scale(scl);
  image(show(), 0, 0);
  noLoop();
  
  println("FINISHED");
  exit();
}

void add() {
  if(mousePressed) {
    int i = mouseX / scl;
    int j = mouseY / scl;
    
    newpile[i][j] += 10;
  }
}
