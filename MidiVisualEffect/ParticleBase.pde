
abstract class ParticleBase {
  int millistamp = millis();
  
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