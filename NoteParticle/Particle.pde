
class Particle {
  int millistamp = millis();
  String text;
  Particle(String name) {
    text = name;
  }
  
  int getAge() {
    return millis() - millistamp;
  }
  
  void render() {
    pushMatrix();
    
    //translate(50, 50);

    int age = getAge();
    float xScale = mouseScaleX();

    println(text + ": " + age + " * " + xScale);
    fill(244);
    text(text, age / 2 * xScale, age / 4);

    rotate(radians(15));
    scale(1.2);
    text(text, age / 2 * xScale, age / 4);


    popMatrix();

  }
}