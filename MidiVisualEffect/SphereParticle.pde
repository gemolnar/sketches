
class SphereParticle extends ParticleBase {

  float _size;
  
  public SphereParticle(float size) {
    _size = size;
  }
  
  void translateAndRenderAt(int t_ms) {
    float grav = (float)t_ms * (float)t_ms / 1400;
    
    float dx = 50 * (width/100) + 150 * sin(radians(t_ms/3));
    float dy = 50 * (height/100) + 150 * cos(radians(t_ms/3));
    float dz = mouseY-grav;
    float noise = noise(dx, dy, dz);

    translate(dx, dy, dz);

    rotateX(radians(t_ms / 10));
    rotateY(radians(t_ms / 12));

    fill(255 - (20*noise), 200, 100 * noise * 20, 150 + noise*100); 
    
    sphere(_size);
  }

}