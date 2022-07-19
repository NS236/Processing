class Pop {
  int popSize;
  Img[] pop;
  Img record;
  Img fittest;
  Img leastFit;
  float maxFitness;
  float minFitness;
  float mutationRate;
  int genCount;

  Pop() {
    this.popSize = 50;
    this.pop = new Img[this.popSize];
    this.record = leastImg;
    this.fittest = leastImg;
    this.leastFit = mostImg;
    this.maxFitness = 0;
    this.minFitness = 0;
    this.mutationRate = 0.005;
    this.genCount = 0;

    for (int i = 0; i < this.popSize; i++) {
      this.pop[i] = new Img();
    }

    leastImg = new Img();
    leastImg.fitness = -Integer.MAX_VALUE;

    mostImg = new Img();
    mostImg.fitness = Integer.MAX_VALUE;
  }

  void select() {
    this.fittest = this.pop[0];
    this.leastFit = this.pop[0];
    for (Img elt : this.pop) {
      elt.calcFitness();
      if (elt.fitness > this.fittest.fitness) {
        this.fittest = elt;
      }
      if (elt.fitness < this.leastFit.fitness) {
        this.leastFit = elt;
      }
    }
    this.maxFitness = this.fittest.fitness;
    this.minFitness = this.leastFit.fitness;
    //if (this.fittest.fitness > this.record.fitness) {
    //  this.record = this.fittest;
    //}
    for (Img elt : this.pop) {
      elt.fitness -= this.minFitness;
      //elt.fitness = pow(elt.fitness, 2);
      elt.pFitness = map(elt.fitness, 0, this.maxFitness - this.minFitness, 0, 1);
    }
  };

  Img pickParent() {
    while (true) {
      int i = floor(random(this.pop.length));
      float a = random(1);
      Img parent = this.pop[i];
      if (a < parent.pFitness) {
        return parent;
      }
    }
  };

  void reproduce() {
    Img[] newPop = new Img[this.pop.length];
    for (var i = 0; i < this.pop.length; i++) {
      var a = this.pickParent();
      var b = this.pickParent();
      var child = a.crossover(b);
      child.mutate(this.mutationRate);
      newPop[i] = child;
    }
    this.pop = newPop;
    this.genCount++;
  };

  void show() {
    this.fittest.show(50, 450, w, h);
  };

  void stats() {
    noStroke();
    fill(255);
    rect(450, 100, 300, 300);
    fill(0);
    textFont(createFont("Trebuchet MS", 20));
    textLeading(60);
    text("Generation: " + this.genCount + "\nVariation: " + round(this.maxFitness - this.minFitness) + "\nFittest: " + round(this.maxFitness) + "\nFrameRate: " + round(frameRate), 450, 120);
  };
}
