
int clipLengthSeconds = 1;
float fr = 50; // FrameRate

void setup() {
  println("Setting up environment.");
  size(1024, 768, P3D);
  frameRate(fr);
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
    float w = width/2;
    float h = height/2;
    translate (w, h);
    
    pushMatrix();
    int spSize = 100;
    translate ((w-spSize) * sin(pos * 2 * PI), 0, 400 * sin(pos * 2 * PI));
    
    sphere(spSize);
    popMatrix();
    
    drawWatermark();

    saveFrame("movie-" + _folderPrefix + "/frame_#####.png");
  } else {
    noLoop();
    generateMovieFile();
  }
}

void drawWatermark() {
  textSize(40);
  text(frameCount, 30, 30);
}


void generateMovieFile() {
   println("Generating movie.");
    ProcessBuilder processBuilder = new ProcessBuilder("ffmpeg.exe", "-r", "60", "-i",
        "movie-" + _folderPrefix + "/frame_%05d.png", "-c:v", "libx264",
        "-r", "30", "-pix_fmt", "yuv420p", _folderPrefix + ".mp4");
        
    try {
      Process process = processBuilder.start();
   
    } catch (Exception e) {
      e.printStackTrace();
    }
}