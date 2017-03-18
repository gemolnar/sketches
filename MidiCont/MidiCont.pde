import themidibus.*;
import spout.*;

Spout _spout;
MidiBus _myBus; // The MidiBus

int[][] _midiControllerState;

void setup() {
    _midiControllerState = new int[16][128];
   _myBus = new MidiBus(this, "LiveToArena", 1);
    _spout = new Spout(this);
    _spout.createSender("Spout Processing");

    MidiBus.list();
    size(1200, 800,  P3D);  
}

float getControllerValue(int channel, int number) {
  return (float)_midiControllerState[channel][number] / (float)128 * width;
}

void draw() {
  background(0);
  
  translate(width/2, height/2);
  float negyvenNyolcas = getControllerValue(0, 48);
  drawElipse(negyvenNyolcas);
  
  _spout.sendTexture();



}

void drawElipse(float d) {
    rotateZ(radians(d));
    rotateX(radians(d/3));

    strokeWeight(10);
    fill(100, 200, 200, 200);
    ellipse(400, 400, d, d);
    fill(200, 000, 200, 100);
    ellipse(100, 100, d*2, d);

}

void controllerChange(int channel, int number, int value) {
  //println(channel + " " + number + " " + value);
  _midiControllerState[channel][number] = value;
}

void noteOn(int channel, int pitch, int velocity) {
  println("noteOn " + channel + " " + pitch + " " + velocity);

}