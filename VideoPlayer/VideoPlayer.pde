/* Plays videos with subtitles provided by an srt file.
   This version assumes subtitles are broken into lines
   of appropriate length in the srt file.
   This version also allows reverse play
*/
import processing.video.*;

String fname = "Ready-Player-One.mp4";
Movie m;

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
}

void movieEvent(Movie m){
  m.read();
}
