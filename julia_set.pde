// here i create variables for the position of the mouse in the main window, which i'll need in the julia set one
float aj;
float bj;

void settings() {
  size(800, 800);

  String[] args = {"TwoFrameTest"};
  SecondApplet sa = new SecondApplet();
  PApplet.runSketch(args, sa);
}

void draw() {
  //times i square the number before deciding if it's valid
  int maxiterations = 100;
  background(0);

  aj = mouseX;
  bj = mouseY;
  //for each pixel on the screen i separate the y and x coordinates for the real and immaginary part
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      float a = map(x, 0, width, -2, 0.75);
      float b = map(y, 0, height, -1.25, 1.25);
      float ca = a;
      float cb = b;

      int n = 0;

      while (n < maxiterations) {
// here i square the number, separately to work with complex numbers
        float aa = a * a - b * b;
        float bb = 2 * a * b;
// add the initial value
        a = aa + ca;
        b = bb + cb;
// if the number expledes then it doesn't satisfy the conditions
        if (a * a + b * b > 16) {
          break;
        }
        n++;
      }
// here i choose the colors, based on random parameters taken from the numbers
      float r = map(a * a + b * b, 0, maxiterations, 0, 1);
      float g = map(a, 0, maxiterations, 0, 1);
      float bb = map(b, 0, maxiterations, 0, 1);
      r = map(sqrt(r), 0, 1, 0, 255);
      g = map(sqrt(g), 0, 1, 0, 255);
      bb = map(sqrt(bb), 0, 1, 0, 255);
//if the number expleded i don't want it to be colored
      if (n == maxiterations) {
        r = 255;
        g = 255;
        bb = 255;
      }
// to draw i just use rectangles
      fill(r, g, bb);
      noStroke();
      rect(x, y, 1, 1);
    }
  }
}    

public class SecondApplet extends PApplet {

  public void settings() {
    size(400, 400);
  }
  public void draw() {
    int maxiterations = 100;
    background(0);
// here i do basically the same thing but for th julia set  
    for (int x = 0; x < 400; x++) {
      for (int y = 0; y < 400; y++) {
        float a = map(x, 0, 400, -2, 0.75);
        float b = map(y, 0, 400, -1.25, 1.25);
        float ca = map(aj, 0, 400,-2, 0.75);
        float cb = map(bj, 0, 400, -1.25, 1.25);

        int n = 0;

        while (n < maxiterations) {
          float aa = a * a - b * b;
          float bb = 2 * a * b;
          a = aa + ca;
          b = bb + cb;
          if (a * a + b * b > 16) {
            break;
          }
          n++;
        }
        float r = map(n, 0, maxiterations, 0, 255);
        if (n == maxiterations) {
          r = 255;
        }
        fill(r);
        noStroke();
        rect(x, y, 1, 1);
      }
    }
  }
}
