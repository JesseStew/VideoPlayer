/* Plays videos with subtitles provided by an srt file.
   This version assumes subtitles are broken into lines
   of appropriate length in the srt file.
   This version also allows reverse play
*/
import processing.video.*;

String fname = "Ready-Player-One.mp4";
Movie m;
boolean paused = false;
float playSpeed = 1.0, mt;

String srtName = "Ready-Player-One-Trailer-HD-English-French-Subtitles.srt";
SubtitlePlayer sp;

void setup() {
  size(640, 350);
  sp = new SubtitlePlayer(srtName);
  frameRate(30);
  m = new Movie(this, fname);
  m.play();
}

void draw() {
  image(m, 0, 0);
  mt = m.time()*1000;
  sp.printSubtitle(sp.subtitle);
}

void movieEvent(Movie m){
  m.read();
}

void mouseWheel (MouseEvent event){
  if(playSpeed > 0){
    playSpeed = playSpeed + event.getCount();
    if(playSpeed == 0){
      playSpeed = 1;
    }
  }else{
    playSpeed = playSpeed + event.getCount();
    if(playSpeed == 0){
      playSpeed = -1;
    }
  }
  println(playSpeed);
  m.speed(playSpeed);
}

void keyReleased() {
  if (key == 'p') {
    //toggle pause
    if (paused){
      paused = false;
      m.play();
    }else{
      paused = true;
      m.pause();
    }
  } else if (key == 'r') {
    //reverse play
    playSpeed = -1*playSpeed;
    m.speed(playSpeed);
  }
}
