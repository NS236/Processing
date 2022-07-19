int dim;
float p;
PVector[] anchors;

ArrayList<Integer> cols;

PVector lastPoint;

void setup() {
  size(800, 800);
  
  background(0);
  dim = 5;
  p = 0.32 + (0.18 * dim / 3);//0.62
  
  anchors = new PVector[dim];
  
  for(float i = 0; i < dim; i++) {
    anchors[int(i)] = PVector.fromAngle(i * TWO_PI / dim - PI / 2);
    anchors[int(i)].mult(width / 2.2);
  }
  
  cols = new ArrayList<Integer>();
  cols.add(#4f00bf);
  cols.add(#dacf32);
  cols.add(#ef7332);
  cols.add(#f0fff4);
  cols.add(#ef3699);
  cols.add(#3279ed);
  
  lastPoint = new PVector(random(width), random(height));
}

void draw() {
  translate(width / 2, height / 2);
  for(int i = 0; i < 10000; i++) {
    int index = floor(random(anchors.length));
    PVector choice = anchors[index];
    
    PVector nextPoint = PVector.lerp(lastPoint, choice, p);
    //stroke(255);
    stroke(cols.get(index % 6));
    point(nextPoint.x, nextPoint.y);
    
    lastPoint = nextPoint;
  }
  
  if(frameCount > 100) {
    noLoop();
  }
}
