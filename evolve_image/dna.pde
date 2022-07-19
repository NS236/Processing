class DNA {
  float genomeLength;
  float mutationAmount;
  PImage img;

  DNA() {
    this.genomeLength = tw * th;
    this.mutationAmount = 0.1;

    this.img = createImage(tw, th, RGB);
    this.img.loadPixels();
    for (int i = 0; i < this.genomeLength; i++) {
      this.img.pixels[i] = color(random(255), random(255), random(255));
    }
    this.img.updatePixels();
  };

  DNA(PImage data) {
    this.genomeLength = tw * th;
    this.mutationAmount = 40;
    this.img = data.copy();
  };

  DNA crossover(DNA dna) {
    PImage newImg = createImage(tw, th, RGB);

    newImg.loadPixels();
    this.img.loadPixels();
    dna.img.loadPixels();

    for (int i = 0; i < this.img.pixels.length; i++) {
      float choice = random(1);
      if (choice > 0.5) {
        newImg.pixels[i] = this.img.pixels[i];
      } else {
        newImg.pixels[i] = dna.img.pixels[i];
      }
    }
    newImg.updatePixels();

    return new DNA(newImg);
  };

  void mutate(float rate) {
    img.loadPixels();
    for (int i = 0; i < this.img.pixels.length; i++) {
      float choice = random(1);
      if (choice < rate) {
        color randCol = color(random(255), random(255), random(255));
        this.img.pixels[i] = lerpColor(this.img.pixels[i], randCol, mutationAmount);
      }
    }
    img.updatePixels();
  };
}
