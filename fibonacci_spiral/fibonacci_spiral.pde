PVector pos;
PVector vel;

ArrayList<PVector> path;

int[] fib;
int fib_dim = 2;
float theta = PI / 3;

 public void setup() {
  size(600, 600);
  pos = new PVector(0, 0);
  vel = new PVector(1, 0);
  
  path = new ArrayList<PVector>();
  path.add(pos.copy());
  
  fib = fibonacci(500);
  //printArray(fib);
}

 public int[] fibonacci(int n) {
  int[] sequence = new int[n];
  for(int i = 0; i < fib_dim; i++) {
    sequence[i] = 1;
  }
  
  int i = fib_dim;
  while(i < n) {
    int sum = 0;
    for(int j = 1; j <= fib_dim; j++) {
      sum += sequence[i-j];
    }
    sequence[i] = sum;
    i++;
  }
  
  return sequence;
}

 public void draw() {
  background(0);
  translate(width / 2, height / 2);
  scale(1, -1);
  
  for(int n : fib) {
    vel.setMag(n % 100);
    pos.add(vel);
    
    path.add(pos.copy());
    
    vel.rotate(theta);
  }
  
  noFill();
  stroke(255);
  beginShape();
  for(PVector p : path) {
    vertex(p.x, p.y);
  }
  endShape();
  
  //printArray(path);
  noLoop();
}
