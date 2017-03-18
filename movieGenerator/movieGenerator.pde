
int clipLengthSeconds = 4;
float fr = 25; // FrameRate
boolean saveFrames = true;

void setup() {
  println("Setting up environment.");
  size(1024, 768, P3D);
  frameRate(fr);
  smooth(4);
  println("Setting up fonts.");
  font1 = createFont("C:\\Windows\\Fonts\\calibri.ttf", 32);
  textFont(font1);
  _folderPrefix = year() + "-" + month() + "-" + day() + "-" + hour() + "-" + minute();
}

PFont font1;
String _folderPrefix;


void draw() {
  float pos = frameCount / (fr * clipLengthSeconds);
  
  if (frameCount < fr * clipLengthSeconds) {
    println(millis() + ": Generating frame #" + frameCount + ".");

    // draw...
    background(0);
    lights();
    float w = width/2;
    float h = height/2;
    translate (w, h);
    
    pushMatrix();
    int spSize = 100;
    translate ((w-spSize) * sin(pos * 2 * PI), 0, 200 * cos(pos * 2 * PI) - 200);
    scale(1, 1, 1.4);
    rotateZ(sin(pos * 2* PI));
    fill(200, 100, 0, 170);
    sphere(spSize);
    popMatrix();

    
    pushMatrix();
    spSize = 60;
    translate ((w-spSize) * sin(pos * 4 * PI), 200 * sin(pos * 2 * PI) - 200, 0);
    scale(1, (1 + (sin(pos * 2 * PI))), 1 + (cos(pos * 2 * PI)));
    rotateY(sin(pos * 2* PI));
    rotateZ(cos(pos * 2* PI));

    fill(200, 100, 250, 240);
    box(spSize);
    popMatrix();

    if (saveFrames) {
      saveFrame("movie-" + _folderPrefix + "/frame_#####.png");
      drawWatermark();
    }

} else {
    noLoop();
    if (saveFrames) {
    generateMovieFile();
    }  
  }
}

void drawWatermark() {
  textSize(40);
  text(frameCount, 30, 30);
}


void generateMovieFile() {
   println("Generating movie.");
    ProcessBuilder processBuilder = new ProcessBuilder("c:\\ffmpeg\\bin\\ffmpeg.exe", "-r", "60", "-i",
        sketchPath("movie-" + _folderPrefix + "/frame_%05d.png"), "-c:v", "libx264",
        "-r", str((int)fr), "-pix_fmt", "yuv420p", sketchPath(_folderPrefix + ".mp4"));
        
    try {
      Process process = processBuilder.start();
    } catch (Exception e) {
      e.printStackTrace();
    }
}