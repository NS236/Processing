import peasy.*;

PeasyCam cam;

int[][][] sandpile;

int[][][] newpile;

color[] col;

int w;
int h;
int d;

int max;

int scl;

boolean edges;

void setup() {
  size(600, 600, P3D);
  noSmooth();
  perspective(PI/3.0, width/height, 0.1, 500);
  
  w = 30;
  h = 30;
  d = 30;
  
  sandpile = new int[w][h][d];
  
  newpile = clone(sandpile);
  
  max = 5;
  
  scl = 5;
  
  col = new color[]{#000000, #fff8f0, #284b63, #f8d822, #ec4067, #777777};
  
  edges = false;
  
  cam = new PeasyCam(this, d * scl * 1.5);

}

int[][][] clone(int[][][] arr) {
  int cols = arr.length;
  int rows = arr[0].length;
  int depth = arr[0][0].length;
  int[][][] newArr = new int[cols][rows][depth];
  
  for(int i = 0; i < cols; i++) {
    for(int j = 0; j < rows; j++) {
      newArr[i][j] = arr[i][j].clone();
    }
  }
  
  return newArr;
}

boolean equal(int[][][] arr1, int[][][] arr2) {
  int cols = arr1.length;
  int rows = arr1[0].length;
  int depth = arr1[0][0].length;
  
  for(int i = 0; i < cols; i++) {
    for(int j = 0; j < rows; j++) {
      for(int k = 0; k < depth; k++) {
        if(arr1[i][j][k] != arr2[i][j][k]) {
          return false;
        }
      }
    }
  }
  
  return true;
}

void topple() {
  for(int i = 0; i < w; i++) {
    for(int j = 0; j < h; j++) {
      for(int k = 0; k < d; k++) {
        if(sandpile[i][j][k] > max) {
          newpile[i][j][k] -= 6;
          if(i > 0) {
            newpile[i-1][j][k] += 1;
          }
          if(i < w - 1) {
            newpile[i+1][j][k] += 1;
          }
          if(j > 0) {
            newpile[i][j-1][k] += 1;
          }
          if(j < h - 1) {
            newpile[i][j+1][k] += 1;
          }
          if(k > 0) {
            newpile[i][j][k-1] += 1;
          }
          if(k < d - 1) {
            newpile[i][j][k+1] += 1;
          }
          
          if(i < 20 || i > w - 20 || j < 20 || j > h - 20 || k < 20 || k > d - 20) {
            edges = true;
          }
        }
      }
    }
  }
}

void show() {
  noStroke();
  for(int i = 0; i < w; i++) {
    for(int j = 0; j < h; j++) {
      for(int k = 0; k < d; k++) {
        int colIndex = sandpile[i][j][k];
        if(colIndex < col.length) {
          fill(col[colIndex]);
        } else {
          fill(255, 0, 0);
        }
        float x = map(i, 0, w, -w/2, w/2);
        float y = map(j, 0, h, -h/2, h/2);
        float z = map(k, 0, d, -d/2, d/2);
        pushMatrix();
        translate(x*scl, y*scl, z*scl);
        float size = constrain(map(colIndex, 0, 5, 0.25, 2), 0.25, 3);
        //if(frameCount == 1) {
        //  println(size);
        //}
        sphere(size);
        popMatrix();
      }
    }
  }
}

void printPile() {
  for(int[][] col : sandpile) {
    for(int[] row : col) {
      printArray(row);
    }
  }
}

void draw() {
  //while(!edges) {
  if(frameCount == 1) {
    newpile[int(w/2)][int(h/2)][int(d/2)] += int(pow(2, 16));
    while(true) {
      
      topple();
      
      if(equal(sandpile, newpile)) {
        break;
      } else {
        sandpile = clone(newpile);
      }
    }
  }
  //}
  
  background(155);
  lights();
  show();
  //printPile();
  //noLoop();
  
  //println("FINISHED");
}
