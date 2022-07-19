// target image
PImage target;
// image width and height
int w;
int h;

// population size
int popSize;
// array of images that make up the population
PImage[] pop;
// array of fitnesses for the population
float[] fitnesses;

// generations
int genCount;

// record fitness
float recordFitness;

// function to generate a random image
PImage randImg(int w, int h) {
  // create the image
  PImage img = createImage(w, h, RGB);
  // load its pixels
  img.loadPixels();
  // loop through each pixels
  for(int i = 0; i < w * h; i++) {
    // set pixel to random color
    img.pixels[i] = randCol();
  }
  // update the image's px
  img.updatePixels();
  
  // return the random img
  return img;
}

// function to generate a random color
color randCol() {
  return color(random(1), random(1), random(1));
}

// calculates the "distance" between two colors
float colDist(color col1, color col2) {
  // get red, blue and green values of each color
  float r1 = red(col1);
  float g1 = green(col1);
  float b1 = blue(col1);
  float r2 = red(col2);
  float g2 = green(col2);
  float b2 = blue(col2);
  
  //dist = sqrt( (r1 - r2)^2 + (g1 - g2)^2 + (b1 - b2)^2 )
  //dist^2 = (r1 - r2)^2 + (g1 - g2)^2 + (b1 - b2)^2
  
  //return distance squared b/c sqrt is computationally costly
  return (r1 - r2) * (r1 - r2) + (g1 - g2) * (g1 - g2) + (b1 - b2) * (b1 - b2);
}

// setup function
void setup() {
  // canvas size
  size(600, 600);
  // rgb values b/w 0-1
  colorMode(RGB, 1, 1, 1);
  
  // load image and set dimensions
  w = 160;
  h = 120;
  target = loadImage("images/tbl-" + str(w) + "_" + str(h) + ".jpg");
  
  // create population
  popSize = 120;
  pop = new PImage[popSize];
  
  // set genCount to zero
  genCount = 0;
  
  // init record fitness
  recordFitness = 0;
  
  // create fitness array
  fitnesses = new float[popSize];
  
  // loop through population
  for(int i = 0; i < popSize; i++) {
    // set each member of population to a random image
    pop[i] = randImg(w, h);
    // set fitnesses to zero
    fitnesses[i] = 0;
  }
};

// draw loop
void draw() {
  // background color black
  background(0);
  
  //save transformations
  push();
  // scaling to make it more visible
  scale((600 - h) / 200);
  
  // draw target image
  image(target, 0, 0);
  
  // display first elt of pop
  image(pop[0], 0, h);
  pop();
  
  // fill color white
  fill(1);
  
  // display generations
  text("Generations: " + str(genCount), 400, 10);
  
  // display record fitness
  text("Record Fitness: " + str(recordFitness), 400, 20, 100, 50);
  
  // display frame rate
  text("Frame Rate: " + str(frameRate), 400, 70);
  
  // reproduce each frame
  reproduce();
  
  // if generations reaches a limit end program
  if(genCount == 10000) {
    noLoop();
  }
};
