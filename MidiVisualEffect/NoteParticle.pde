
class NoteParticle extends Particle {
  
  int _fontIndex;
  
  public NoteParticle(String name, int fontIndex) {
    super(name);
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
    text(text, 0, 0);

    if (false) {
      rotateX(radians(t_ms / 8));
      rotateY(radians(t_ms / 10));
      scale(1.5);
      text(text, 0, 15, 200 - af);
    }
  }
}