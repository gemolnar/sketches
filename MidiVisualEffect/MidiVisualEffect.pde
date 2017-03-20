import themidibus.*;
import spout.*;

////////////////////////////////////////////////////////////////////// Config



////////////////////////////////////////////////////////////////////// Globals

Particles _particles = new Particles();
Spout _spout;
MidiBus _myBus;
ArrayList<PFont> _fonts;

////////////////////////////////////////////////////////////////////// Setup

void setup() {
  println("Set up CONFIG ---------------------------");
  String MIDI_IN = "LiveToArena";
  String MIDI_OUT = "ArenaToLive";
  String fontName = "c:\\windows\\fonts\\impact.ttf";
  
  println("Set up GRAPHICS ---------------------------");
  size(1200, 800, P3D); 
  println ("Size: " + width + "x" + height);
  lights();
  background(0);
  _spout = new Spout(this);
  _spout.createSender("MIDI-Vizer #" + MIDI_IN);

  println("Set up FONTS ---------------------------");
  _fonts = new ArrayList<PFont>();
  println("Loading '" + fontName + "'.");
  _fonts.add(createFont(fontName, 10));
  _fonts.add(createFont(fontName, 32));
  _fonts.add(createFont(fontName, 68));
  textFont(_fonts.get(0));
  
  println("Set up MIDI ---------------------------");
  //MidiBus.list();
  println ("MIDI IN: " + MIDI_IN);
  println ("MIDI OUT: " + MIDI_OUT);
  _myBus = new MidiBus(this, MIDI_IN, MIDI_OUT);
}

////////////////////////////////////////////////////////////////////// Events
////////////////////////////////////////////////////////// Draw
void draw() {
  background(0, 0, 0, 0);
  _particles.removeOlderThan(4000);
  _particles.render();

  _spout.sendTexture();

  //fill(0, 0, 0, 0);
  //int n = 20;
  //for (int i = 0; i < n; i++) {
  //  fill(i*10);
  //  ellipse(500, 500, 500 - mouseX, 500 - i * 15);
  //}

}

////////////////////////////////////////////////////////// Key press
void keyPressed() {
  Particle p = new NoteParticle(str(key),1);
  _particles.add(p);
}

////////////////////////////////////////////////////////// General MIDI message
void midiMessage(javax.sound.midi.MidiMessage message, long timeStamp) {
  println("Message received. Status: " + message.getStatus() + ", Timestamp: " + timeStamp);
}

////////////////////////////////////////////////////////// MIDI Note on
void noteOn(int channel, int pitch, int velocity) {
  // 'channel' is zero indexed (9 means channel 10)
  println ("MIDI.Note O " + pitch + " [vel:" + velocity + ", ch#" + (channel) + "]");  
  if (channel == 9) {
    if (pitch == 36) {
      println("Adding Kick particle");
      Particle p = new NoteParticle("Kick", 2);
      _particles.add(p);
    }
   if (pitch == 37) { 
      Particle p = new NoteParticle("Snare", 1);
      _particles.add(p);
    }
   if (pitch == 38) { 
      Particle p = new NoteParticle("hihats", 0);
      _particles.add(p);
    }
  }
}

////////////////////////////////////////////////////////// MIDI Note off
void noteOff(int channel, int pitch, int velocity) {
  //println ("MIDI.Note - " + pitch + " [vel:" + velocity + ", ch#" + (channel) + "]"); 
}

////////////////////////////////////////////////////////// MIDI Controller change
void controllerChange(int channel, int number, int value) {
  println ("MIDI.CC #" + number + ": " + value + "[ch#" + (channel) + "]");
}