
class Particles extends ArrayList<ParticleBase> {
  
  void removeOlderThan(int maxAgeMillis) {
    for (int i = size() - 1; i >= 0; i--) {
      ParticleBase p = get(i);
      if (p.getAge() > maxAgeMillis) {
        remove(i);
      }
    }
  }
  
  void render() {
    for (int i = 0; i < size();  i++) {
      ParticleBase p = get(i);
      p.render();    
    }
  }

}