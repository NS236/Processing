PImage night;

ArrayList<Rocket> fireworks;
ArrayList<Spark> sparks;

int max = 15;

void setup() {
  //size(600, 600);
  fullScreen();
  colorMode(HSB);
  
  background(0);
  stroke(255);
  for(int i = 0; i < 500; i++) {
    strokeWeight(random(2));
    float x = random(width);
    float y = random(height);
    if(random(1) < 1 - pow(y / height, 0.01)) {
      point(x, y);
    } else {
      i--;
    }
  }
  
  night = get();
  
  fireworks = new ArrayList<Rocket>();
  for(int i = 0; i < max; i++) {
    fireworks.add(new Rocket());
  }
  
  sparks = new ArrayList<Spark>();
}

void draw() {
  image(night, 0, 0);
  for(int i = 0; i < fireworks.size(); i++) {
    fireworks.get(i).update();
    fireworks.get(i).show();
    
    if(fireworks.get(i).dead) {
      fireworks.remove(i);
    }
  }
  
  if(fireworks.size() < max) {
    fireworks.add(new Rocket());
  }
  
  for(int i = 0; i < sparks.size(); i++) {
    sparks.get(i).update();
    sparks.get(i).show();
    
    if(sparks.get(i).dead) {
      sparks.remove(i);
    }
  }
  
  text(round(frameRate), width - 20, height - 20);
}
