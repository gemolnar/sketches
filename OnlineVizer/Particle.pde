
abstract class Particle {
  int millistamp = millis();
  String text;
  public Particle(String name) {
    text = name;
  }
  
  int getAge() {
    return millis() - millistamp;
  }
  
  void render() {
    pushMatrix();
    int age = getAge();
    translateAndRenderAt(age);
    popMatrix();
  }
  
  abstract void translateAndRenderAt(int t_ms);
}