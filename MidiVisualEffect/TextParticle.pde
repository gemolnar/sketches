
class TextParticle extends ParticleBase {

  String _text;
  int _fontIndex;
  
  public TextParticle(String text, int fontIndex) {
    _text = text;
    _fontIndex = fontIndex;
  }
  
  void translateAndRenderAt(int t_ms) {
    float af = (float)t_ms * (float)t_ms / 3000;
    
    translate((width/10)*4 + af/2, (height/10) * 6, mouseY-af);

    rotateX(radians(t_ms / 100));
    rotateY(radians(af / 100));
    rotateZ(-radians(t_ms / 10));

    fill(244, 100, 255, 150); 
    
    textFont(_fonts.get(_fontIndex));
    text(_text, 0, 0);
  }
  
}