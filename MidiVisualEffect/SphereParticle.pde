
class SphereParticle extends ParticleBase {

  float _size;
  
  public SphereParticle(float size) {
    _size = size;
  }
  
  void translateAndRenderAt(int t_ms) {
    float grav = (float)t_ms * (float)t_ms / 3000;
    
    float dx = 40 * (width/100) + 80 * sin(radians(t_ms/3));
    float dy = 60 * (height/100) + 80 * cos(radians(t_ms/3));
    float dz = mouseY-grav;
    float noise = noise(dx, dy, dz);

    translate(dx, dy, dz);

    rotateX(radians(t_ms / 10));
    rotateY(radians(t_ms / 12));

    fill(255 - (200-noise), 100, 255 * noise, 150 + noise*100); 
    
    sphere(_size);
  }

}