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
String currentKey = "void";
String currentSubtitle = "void";

String srtName = "Ready-Player-One-Trailer-HD-English-French-Subtitles.srt";
SubtitleP sp;

void setup() {
  size(640, 350);
  sp = new SubtitleP(srtName);
  frameRate(30);
  m = new Movie(this, fname);
  m.play();
  //println(sp.subtitle);
}

void draw() {
  findCurrentKey(sp);
  //println(currentKey, "   ", mt);
  currentSubtitle = sp.subtitle.get(currentKey);
  //println(currentSubtitle);
  background(0);
  image(m, 0, 0);
  mt = m.time()*1000;
  //sp.printSubtitle(sp.subtitle);
  //textSize(18);
  if (currentSubtitle != null){
    text(currentSubtitle, 90, 300);
  }
  textSize(24);
  text(playSpeed, 550, 330);
}

void movieEvent(Movie m){
  m.read();
}

void findCurrentKey(SubtitleP sp){
  String[] keys = sp.subtitle.keyArray();
  for(int i = 0; i < keys.length; i++){
    //compares key values to mt and updates currentKey value
    if(sp.parseTime(sp.createEndTimeArr(keys[i])) > mt 
       && sp.parseTime(sp.createStartTimeArr(keys[i])) < mt){
         currentKey = keys[i];
    }
  }
}

void mouseWheel (MouseEvent event){
  if(playSpeed > 0){
    playSpeed = playSpeed + -1*(0.01*event.getCount());
    playSpeed = Math.round(playSpeed * 100.0) / 100.0;  //Gets rid of extra decimal places
    if(playSpeed < 0.1){
      playSpeed = 0.1;
    }else if(playSpeed > 2.0){
      playSpeed = 2.0;
    }
  }
  //Speed seems to only change at multiples of .1 not .01
  //println(playSpeed);
  m.speed(playSpeed);  
}

void keyReleased() {
  if (key == ' ') {
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
    if(playSpeed > 0){
      playSpeed = -1.0;
    }else{
      playSpeed = 1.0;
    }
    m.speed(playSpeed);
  }
}
