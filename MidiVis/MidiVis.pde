import themidibus.*;
import spout.*;

class MidiStatus {
  boolean isNoteOn;
  int milliStamp;
  int velocity;
  //MidiStatus (boolean isOn, int timestampInMillis) {  
  //  isNoteOn = isOn;
  //  milliStamp = timestampInMillis; 
  //} 
  void update() { 
  }
} 

Spout _spout;
MidiBus _myBus; // The MidiBus

MidiStatus[][] midiStatus;

PFont font1, font2;


void setup() {
  midiStatus = new MidiStatus[16][128];
  for (int channel = 0; channel < 16; channel++) {
    for (int note = 0; note < 128; note++) {
      midiStatus[channel][note]=new MidiStatus();
    }
  }
  
  
  size(1800, 950, P3D);
  background(0);

  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.


  _myBus = new MidiBus(this, "LiveToArena", "ArenaToLive");
  _spout = new Spout(this);
  _spout.createSender("vizer Spout Out");

  
  String[] fontList = PFont.list();
  printArray(fontList);
  
  font1 = createFont("C:\\Windows\\Fonts\\impact.ttf", 32);
  font2 = createFont("C:\\Windows\\Fonts\\calibri.ttf", 38);

}

void drawBass(float x, float y, float w, float h) {
  
  float bw = w / 25;
    
  // draw the neck
  fill(139, 69, 19);
  stroke(0);
  rect(x, y, w, h);
  fill(100, 40, 5);
  rect(x, y, bw, h);

  // draw bunds and markers
  for (int bi = 0; bi < 24; bi++) {
    stroke(200);
    strokeWeight(1 + (15 / (bi+1)));
    line(x + bw + bi * bw, y, x + bw + bi * bw, y + h);
    switch(bi) {
      case 3:
      case 5:
      case 7:
      case 15:
      case 17:
      case 19:
        stroke(25);
        strokeWeight(4);
        fill(0);
        ellipse(x + bw * 2.5 + bi * bw, y + h /2, 10, 10);
        break;
      case 10:
      case 22:
        stroke(25);
        strokeWeight(6);
        fill(0);
        ellipse(x + bw * 2.5 + bi * bw, y + h /2, 10, 60);
        break;
    }
  }
  
  // draw strings 
  float stringDistance = h / 4;
  float stringY = y + stringDistance / 2;
  stroke(240);
  for (int si = 0; si < 4; si++) {
    strokeWeight(5-si);
    line(x, stringY, x + w, stringY);
    stringY = stringY + stringDistance;
  }
  
  // draw notes
  textFont(font2);
  for(int pitch = 0; pitch < 128; pitch++){
    int isNoteVisible = 0;
    
    if (midiStatus[0][pitch].isNoteOn)
      isNoteVisible = midiStatus[0][pitch].velocity;
    else if (millis() - midiStatus[0][pitch].milliStamp < 100){
      isNoteVisible = 127 - (millis() - midiStatus[0][pitch].milliStamp);
    }
    
    if(isNoteVisible > 0) {
      int offset = -1;
      for(int si = 0; si < 4; si++) {
        switch(si) {
          case 0:
            offset = pitch - 28;
            stringY = y + stringDistance * 0.5;
            break;
          case 1:
            offset = pitch - 28 - 5;
            stringY = y + stringDistance * 1.5;
            break;
          case 2:
            offset = pitch - 28 - 10;
            stringY = y + stringDistance * 2.5;
            break;
          case 3:
            offset = pitch - 28 - 15;
            stringY = y + stringDistance * 3.5;
            break;
        }
        
      if (offset > -1 && offset < 24) {
        fill(isNoteVisible / 2, 0, 0, isNoteVisible * 2);
        ellipse(x  + bw / 2 + offset * bw, stringY, 25, 35) ;
        fill(255, 255, 255);
        text(toMidiNote(pitch % 12),  x  + bw / 2 + offset * bw - 5, stringY + 5) ;
      }
      }
       
    }
  }
}



void drawGuitar(float x, float y, float w, float h) {
  
  float bw = w / 25;
    
  // draw the neck
  fill(139, 69, 19);
  stroke(0);
  rect(x, y, w, h);
  fill(100, 40, 5);
  rect(x, y, bw, h);

  // draw bunds and markers
  for (int bi = 0; bi < 24; bi++) {
    stroke(200);
    strokeWeight(1 + (15 / (bi+1)));
    line(x + bw + bi * bw, y, x + bw + bi * bw, y + h);
    switch(bi) {
      case 3:
      case 5:
      case 7:
      case 15:
      case 17:
      case 19:
        stroke(25);
        strokeWeight(4);
        fill(0);
        ellipse(x + bw * 2.5 + bi * bw, y + h /2, 10, 10);
        break;
      case 10:
      case 22:
        stroke(25);
        strokeWeight(6);
        fill(0);
        ellipse(x + bw * 2.5 + bi * bw, y + h /2, 10, 60);
        break;
    }
  }
  
  // draw strings 
  float stringDistance = h / 6;
  float stringY = y + stringDistance / 2;
  stroke(240);
  for (int si = 0; si < 6; si++) {
    strokeWeight(5-si);
    line(x, stringY, x + w, stringY);
    stringY = stringY + stringDistance;
  }
  
  // draw notes
  textFont(font2);
  for(int pitch = 0; pitch < 128; pitch++){
    int isNoteVisible = 0;
    
    if (midiStatus[0][pitch].isNoteOn)
      isNoteVisible = midiStatus[0][pitch].velocity;
    else if (millis() - midiStatus[0][pitch].milliStamp < 200){
      isNoteVisible = 200 - (millis() - midiStatus[0][pitch].milliStamp);
    }
    
    if(isNoteVisible > 0) {
      int offset = -1;
      for(int si = 0; si < 6; si++) {
        switch(si) {
          case 0:
            offset = pitch - 40;
            stringY = y + stringDistance * 0.5;
            break;
          case 1:
            offset = pitch - 40 - 5;
            stringY = y + stringDistance * 1.5;
            break;
          case 2:
            offset = pitch - 40 - 10;
            stringY = y + stringDistance * 2.5;
            break;
          case 3:
            offset = pitch - 40 - 15;
            stringY = y + stringDistance * 3.5;
            break;
          case 4:
            offset = pitch - 40 - 19;
            stringY = y + stringDistance * 4.5;
            break;
          case 5:
            offset = pitch - 40 - 24;
            stringY = y + stringDistance * 5.5;
            break;
        }
          
        if (offset > -1 && offset < 24) {
          fill(isNoteVisible / 2, 0, 0, isNoteVisible * 5);
          ellipse(x  + bw / 2 + offset * bw, stringY, 25, 35) ;
  
          fill(0, 0, 0);
          textSize(38);
          text(toMidiNote(pitch % 12),  x  + bw / 2 + offset * bw - 5, stringY + 5) ;
  
          int n = pitch % 12;
          fill((n % 3) * 120, (n % 5) * 63, pitch*2);
          textSize(32);
          text(toMidiNote(n),  x  + bw / 2 + offset * bw - 5, stringY + 5) ;
        }  
      }
    }
  }
}

void drawBeatyNote() {
  // draw notes
  textFont(font1);
  int noteCrossMillis = 3000;
  int nowMillis = millis();
  for(int pitch = 0; pitch < 128; pitch++){
    int noteAge = nowMillis - midiStatus[0][pitch].milliStamp;
    if (midiStatus[0][pitch].isNoteOn) {
      //isNoteVisible = midiStatus[0][pitch].velocity;
      if (noteAge < noteCrossMillis) {
        fill(0, 0, 0);
        textSize(120);
        float y = height - (((float)noteAge / (float)noteCrossMillis)  * (float)height);
        text(toMidiNote(pitch % 12),  500, y);
      }
    }
    else {
      if (noteAge < 1100) {
        fill(0, 0, 0);
        textSize(120);
        float y = height - (((float)noteAge / (float)noteCrossMillis)  * (float)height);
        text(toMidiNote(pitch % 12),  500, y);
      }
    }
  }
}

void draw() {
  background(100,0,0);
  drawGuitar(0, 20, 1800, 160);

  drawPianoKeyboard(0, 200, 450, 280, 5); 
  drawPianoKeyboard(450, 200, 450, 280, 6); 
  drawPianoKeyboard(900, 200, 450, 280, 7); 
  drawPianoKeyboard(1350, 200, 450, 280, 8); 

  drawPianoKeyboard(0, 650, 450, 280, 2); 
  drawPianoKeyboard(450, 650, 450, 280, 3); 
  drawPianoKeyboard(900, 650, 450, 280, 4); 
  drawPianoKeyboard(1350, 650, 450, 280, 5); 

  
  drawBass(0, 500, 1800, 130);
  
  textFont(font1);
  
  drawBeatyNote();
  
    _spout.sendTexture();

  //for (int channel = 0; channel < 16; channel++) {
  //  for (int pitch = 0; pitch < 128; pitch++) {
  //    int since = millis() - midiStatus[channel][pitch].milliStamp;
  //    int note = pitch % 12;
  //    int octave = pitch / 12;
  //    if (midiStatus[channel][pitch].isNoteOn) {
  //        fill(midiStatus[channel][pitch].velocity * 2);
  //        text(toMidiNote(note), width / 12 * note, octave * 60);
  //    }
  //    else if (since < 256) {
  //      fill(255 - since);
  //      text(toMidiNote(note), width / 12 * note, octave * 60);
  //    }
      
  //  }
  //}
}

void drawWhiteKey(int keyPositionOffset, float x, float y, float kw, float kh, boolean noteOn) {
 String noteName = "?";
 switch(keyPositionOffset) {
   case 0:
     noteName = "C";
     break;
   case 1:
     noteName = "D";
     break;
   case 2:
     noteName = "E";
     break;
   case 3:
     noteName = "F";
     break;
   case 4:
     noteName = "G";
     break;
   case 5:
     noteName = "A";
     break;
   case 6:
     noteName = "B";
     break;
 }
 
  fill(255);
  if (noteOn) {
    stroke(128, 0, 0);
    strokeWeight(10);
  } else {
    stroke(128);
    strokeWeight(1);
  }
  rect(x + keyPositionOffset * kw, y, kw, kh, 0, 0, 7, 7);
  
  textFont(font1);
  if (noteOn)
    fill(0);
  else
    fill(230);
  text(noteName, x + keyPositionOffset * kw + kw * 0.35, y + kh * 0.85);
//  ellipse(x + keyPositionOffset * kw + kw / 2, y + kh * 0.8, 40, 40);

}

void drawBlackKey(int keyPositionOffset, float x, float y, float kw, float kh, boolean noteOn) {
 String noteName = "XX";
 switch(keyPositionOffset) {
   case 0:
     noteName = "C#";
     break;
   case 1:
     noteName = "D#";
     break;
   case 3:
     noteName = "F#";
     break;
   case 4:
     noteName = "G#";
     break;
   case 5:
     noteName = "A#";
     break;
 }
  fill(0);
  if (noteOn) {
    stroke(200, 0, 0);
    strokeWeight(6);
  } else {
    stroke(0);
    strokeWeight(1);
  }
  float bkw = kw * 0.7;
  rect(x + keyPositionOffset * kw + (kw - bkw / 2) , y, bkw, kh * 0.6, 0, 0, 7, 7);
  textFont(font1);
  if (noteOn)
    fill(200);
  else
    fill(20);
  text(noteName, x + keyPositionOffset * kw + (kw - bkw / 2) , y + kh / 3);
}



void drawPianoKeyboard(float x, float y, float w, float h, int octave) {
  fill(255);
  stroke(128, 0, 0);
  strokeWeight(10);  // Default

  float whiteKeyWidth = w / 7;
  
  for (int note = 0; note < 12; note++) {
   boolean noteOn = midiStatus[0][octave*12 + note].isNoteOn;
   switch(note) {
     case 0: // C
       drawWhiteKey(0, x, y, whiteKeyWidth, h, noteOn); 
       break;
     case 2: // D
       drawWhiteKey(1, x, y, whiteKeyWidth, h, noteOn); 
       break;
     case 4: // E
       drawWhiteKey(2, x, y, whiteKeyWidth, h, noteOn); 
       break;
     case 5:  // F
       drawWhiteKey(3, x, y, whiteKeyWidth, h, noteOn); 
       break;
     case 7:  // G
       drawWhiteKey(4, x, y, whiteKeyWidth, h, noteOn); 
       break;
     case 9: // A
       drawWhiteKey(5, x, y, whiteKeyWidth, h, noteOn); 
       break;
     case 11: // B
       drawWhiteKey(6, x, y, whiteKeyWidth, h, noteOn); 
       break;
    } 
  }

  for (int note = 0; note < 12; note++) {
   boolean noteOn = midiStatus[0][octave*12 + note].isNoteOn;
   switch(note) {
     case 1: // C#
       drawBlackKey(0, x, y, whiteKeyWidth, h, noteOn); 
       break;
     case 3: // D#
       drawBlackKey(1, x, y, whiteKeyWidth, h, noteOn); 
       break;
     case 6:   // F#
       drawBlackKey(3, x, y, whiteKeyWidth, h, noteOn); 
       break;
     case 8: // G#
       drawBlackKey(4, x, y, whiteKeyWidth, h, noteOn); 
       break;
     case 10: // A#
       drawBlackKey(5, x, y, whiteKeyWidth, h, noteOn); 
       break;
    } 
  }
  
  //float kw = w / 7;  
  //for(int ki = 0; ki < 7; ki++) {
    
  //  rect(x + ki * kw, y, kw, h, 0, 0, 7, 7);
  //}
  
  //fill(0);
  //float skw = kw * 0.6;
  //for(int ski = 0; ski < 7; ski++) {
  //  if (ski == 2 || ski == 6)
  //    continue;
      
  //  rect(x + kw + ski * kw - skw / 2, y, skw, h * 0.7, 0, 0, 7, 7);
  //}
  
}



void noteOn(int channel, int pitch, int velocity) {
  midiStatus[channel][pitch].isNoteOn = true;
  midiStatus[channel][pitch].milliStamp = millis();
  midiStatus[channel][pitch].velocity = velocity;
}

void noteOff(int channel, int pitch, int velocity) {
  midiStatus[channel][pitch].isNoteOn = false;
  midiStatus[channel][pitch].milliStamp = millis();
  midiStatus[channel][pitch].velocity = velocity;
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
}

String toMidiNote(int note) {
 switch (note) {
   case 0:
   return "C";
   case 1:
   return "C#";
   case 2:
   return "D";
   case 3:
   return "D#";
   case 4:
   return "E";
   case 5:
   return "F";
   case 6:
   return "F#";
   case 7:
   return "G";
   case 8:
   return "G#";
   case 9:
   return "A";
   case 10:
   return "A#";
   case 11:
   return "B";
   default:
   return "X";
 }
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}