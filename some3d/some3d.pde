
float currentAgeSeconds;
float sips;
float cops;
PFont font1, font2;


void setup() {
  size(1200, 800, P3D);
  smooth(8);
  font1 = createFont("C:\\Windows\\Fonts\\impact.ttf", 32);
  font2 = createFont("C:\\Windows\\Fonts\\calibri.ttf", 32);
  textFont(font1);

}


void draw() {
  currentAgeSeconds = (float)millis() / 4000;
  sips = sin(currentAgeSeconds * 2 * PI);
  cops = sin(currentAgeSeconds * 2 * PI);
  background(0);
  lights();
  translate(width / 2, height / 2);
  
  d1();
  d2();
}


void d1 () {
  pushMatrix();
  float y = currentAgeSeconds * currentAgeSeconds * 4;
  translate(y * sips, (y - 200));
  scale(sips * 3);
  rotateZ(sips);
  fill(200, 100, 0, 170);
  stroke(3);
  box(300);
    textSize(42);
  text("hello",  200, 200);
  popMatrix();
}


void d2 () {
  pushMatrix();
  float y = currentAgeSeconds * currentAgeSeconds * 4;
  translate(0, sips * 30, 1000 - currentAgeSeconds * 70);
  rotateX(sips);
    scale(sips * 3);

  fill(200, 100, 0, 170);
  stroke(5);
  textSize(42);
  text("hello",  200, 200);

  //sphere(150);
  popMatrix();
}