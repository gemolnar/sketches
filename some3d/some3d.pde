
void setup() {
  size(640, 480);
}


void draw() {
  background(0);
  
  pushMatrix();
  
  popMatrix();
  
  fill(200);
  int age = millis();
  float y = age * age / 4000;
  translate(50, y);
  ellipse(0,0,30,30);
}