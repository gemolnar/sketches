
class Particles extends ArrayList<Particle> {
  void removeOlderThan(int maxAgeMillis) {
    for (int i = size() - 1; i >= 0; i--) {
      Particle p = get(i);
      if (p.getAge() > maxAgeMillis) {
        remove(i);
      }
    }
  }
  void render() {
    for (int i = 0; i < size();  i++) {
      Particle p = get(i);
      p.render();    
    }
  }
}