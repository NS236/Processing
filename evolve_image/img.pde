class Img {
  DNA dna;
  float fitness;
  float pFitness;
  
  Img() {
    this.dna = new DNA();
    this.fitness = 0;
    this.pFitness = 0;
  }

  Img(DNA dna) {
    this.dna = dna;
    this.fitness = 0;
    this.pFitness = 0;
  };

  void calcFitness() {
    color[] genes = this.dna.img.pixels;
    for (int i = 0; i < genes.length; i++) {
      if (round(genes[i]) == targetImage.pixels[i]) {
        this.fitness += 2;
      } else {
        this.fitness += (255 - abs(genes[i] - targetImage.pixels[i])) / 100;
      }
    }
  };

  Img crossover(Img img) {
    DNA newDNA = this.dna.crossover(img.dna);
    return new Img(newDNA);
  };

  void show(float x, float y, float w, float h) {
    drawImage(this.dna.img, x, y, w, h);
  };

  void mutate(float rate) {
    this.dna.mutate(rate);
  };
}
