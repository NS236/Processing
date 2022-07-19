// reproducing
void reproduce() {
  // create new empty population
  PImage[] newPop = new PImage[popSize];
  
  // calculate fitness of current population
  calcFitness();
  
  // repeat as many times as elts of the pop
  for(int i = 0; i < popSize; i++) {
    // select two parents
    PImage parent1 = selectParent();
    PImage parent2 = selectParent();
    
    // cross the parents to create a child
    PImage child = crossover(parent1, parent2);
    // mutate the child
    mutateChild(child);
    
    // add the child to the new pop
    newPop[i] = child;
  }
  
  // replace pop with new pop
  pop = newPop;
  // increase generation count
  genCount++;
};


// setting fitness values for each member of the population
void calcFitness() {
  float maxFitness = 0;
  float minFitness = PI;
  // range b/w max and min fitness
  float diffFitness = 0;

  // load target image px
  target.loadPixels();
  // loop through each img in population
  for (int i = 0; i < popSize; i++) {
    // fitness for each image begins at zero
    float fitness = 0;
    // load px of current image
    pop[i].loadPixels();

    //loop through px of image
    for (int j = 0; j < w * h; j++) {
      // current px of current img
      color px = pop[i].pixels[j];
      // current px of target img
      color tpx = target.pixels[j];

      // color distance b/w current and target px
      float dist = colDist(px, tpx);

      // add color distance to fitness
      fitness += dist;
    }

    // invert fitness so higher values mean better fitness
    fitness = (1 / fitness);

    // if min fitness is not set or fitness is less than min fitness
    if (minFitness == PI || fitness < minFitness) {
      // set min fitness to current px fitness
      minFitness = fitness;
    }

    // if fitness is greater than max fitness
    if (fitness > maxFitness) {
      // set max fitness to fitness
      maxFitness = fitness;
    }
    
    // if max fitness is greater than record fitness
    if (maxFitness > recordFitness) {
      // set record fitness to max fitness
      recordFitness = maxFitness;
    }

    // set index in fitnesses array to calculated fitness
    fitnesses[i] = fitness;
  }

  // calculate range of fitnesses
  diffFitness = maxFitness - minFitness;

  // loop through each image
  for (int i = 0; i < popSize; i++) {
    // get current fitness
    float fitness = fitnesses[i];
    // subtract min fitness; new range: 0 - diff fitness
    fitness = fitness - minFitness;
    // divide by diff fitness; new range: 0 - 1
    fitness = fitness / diffFitness;
    // set value to normalized fitness
    fitnesses[i] = fitness;
  }
};


// select a parent
PImage selectParent() {
  // create a parent image
  PImage parent;

  // loop until a parent is found
  while (true) {
    // get a random element of the population
    int index = floor(random(popSize));
    parent = pop[index];

    // get random value 0-1
    float r = random(1);
    // if random value is less than normalized fitness return parent
    if (r < fitnesses[index]) {
      // the fitness of a given elt is its probability of being picked
      return parent;
    }
  }
};


// crossover 2 parents to create a child
PImage crossover(PImage p1, PImage p2) {
  // create child image
  PImage child = createImage(w, h, RGB);

  // load pixels of parents and child
  p1.loadPixels();
  p2.loadPixels();
  child.loadPixels();

  // loop through all px
  for (int i = 0; i < w * h; i++) {
    // get random value b/w 0-1
    float r = random(1);
    // 50% of the time
    if (r < 0.5) {
      // set child px to parent 1 px
      child.pixels[i] = p1.pixels[i];
    }
    // other 50% of the time
    else {
      // set child px to parent 2 px
      child.pixels[i] = p2.pixels[i];
    }
  }

  // update child px
  child.updatePixels();
  // return child
  return child;
};


// randomly mutate the child
void mutateChild(PImage child) {
  // mutation params
  float rate = 0.005;
  float magnitude = 0.15;

  // load child pixels
  child.loadPixels();
  // iterate thru each px
  for (int i = 0; i < w * h; i++) {
    // random val
    float r = random(1);
    // if val is less than rate
    if (r < rate) {
      // generate random col
      color col = randCol();
      // lerp current color to randomized color by magnitude
      child.pixels[i] = lerpColor(child.pixels[i], col, magnitude);
    }
  }
  // update child px
  child.updatePixels();
}
