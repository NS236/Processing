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
  size(640, 480);
  background(0);
  
  int num = 1732232178;
  int[] factors = pf(num);
  
  textAlign(CENTER, CENTER);
  
  textFont(createFont("courier", 100));
  text(num, width / 2, height / 4);
  textSize(30);
  String fctrs = " ";
  for(int factor : factors) {
    fctrs += str(factor) + " ";
  }
  
  text(fctrs, width / 2, height * 3 / 4);
  
  print("DONE");
}
