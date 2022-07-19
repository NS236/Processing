int index;
int max;

int[] px;

boolean dv(int a, int b) {
  return (a % b == 0);
}

int[] join(int[] a, int[] b) {
  int[] ab = new int[a.length + b.length];
  
  for(int i = 0; i < a.length; i++) {
    ab[i] = a[i];
  }
  
  for(int i = 0; i < b.length; i++) {
    ab[i + a.length] = b[i];
  }
  
  return ab;
}

boolean isPrime(int n) {
  int i = 2;
  float val = n / i;
  while(i <= val) {
    if(dv(n, i)) {
      return false;
    } else {
      i++;
      val = n / i;
    }
  }
  
  return true;
}

int[] pf(int n) {
  if(isPrime(n)) {
    return new int[]{n};
  }
  
  int i = 2;
  float val = n / i;
  while(i <= val) {
    if(dv(n, i)) {
      return join(new int[]{i}, pf(n/i));
    } else {
      i++;
      val = n / i;
    }
  }
  
  return new int[]{};
}

void setup() {
  size(800, 800);
  
  index = 0;
  max = int(log(width * height) / log(2));
  
  px = new int[(width * height)];
  
  textAlign(CENTER, CENTER);
  textFont(createFont("courier", 100));
}

void draw() {
  int[] factors;
  for(int i = 0; i < 10000; i++) {
    factors = pf(index);
    
    px[index] = factors.length;
    
    index++;
    
    if(index >= width * height) {
      break;
    }
  }
  
  if(index >= width * height) {
    loadPixels();
    for(int i = 0; i < px.length; i++) {
      if(px[i] == 1 && i != 0) {
        pixels[i] = color(255);
        //pixels[i] = color(map(i, 0, width * height, 100, 255));
      } else {
        pixels[i] = color(0);
      }
    }
    updatePixels();
    noLoop();
    print("DONE");
  }
}
