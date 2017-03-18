
Particles particles = new Particles();
PFont font1, font2;

//////////////////////////////////////////////// Setup and events

void setup() {
  size(640, 360); 
  background(0);
  font1 = createFont("c:\\windows\\fonts\\impact.ttf", 32);
  font2 = createFont("c:\\windows\\fonts\\impact.ttf", 38);
  //lights();
  textFont(font1);
}

void draw() {
  background(20);
  particles.removeOlderThan(2000);
  particles.render();
  
  //fill(100);
  //int n = 20;
  //for (int i = 0; i < n; i++) {
  //  fill(i*10);
  //  ellipse(500, 500, 500 - mouseX, 500 - i * 15);
  //}

}

void keyPressed() {
  Particle p = new Particle(str(key));
  particles.add(p);
}

//////////////////////////////////////////////// Functions

 float mouseScaleX() {
   float scale =  mouseX / width;
   return scale;
 }