class SubtitlePlayer {
  String arrow = "-->";  //Arrow separating start time from end time
  String tokens = ":,";
  String[] lines;
  
  SubtitlePlayer(String fname) {
    //Load the file into the lines array
    lines = loadStrings(fname);
    
    int i = 0;
    while (i < lines.length) {
      //If the line contains an arrow, you have a new subtitle - get it into a StringList
      if(lines[i].contains(arrow)){
        StringList subtitle = new StringList();
        subtitle.append(lines[i++]);
        //While the line is not blank
        while (lines[i].length() > 0){
          //Append line to subtitle
          subtitle.append(lines[i++]);
        }
        printSubtitle(subtitle);
        println();  //Blank line to separate the subtitles
      }
      i++;  //Go to next line
    }
  }
  int parseTime(String[] timeArr) {
    //Returns time in ms; time array has format hours, minutes, seconds, milliseconds
    int t = 0;  //Replace this with time calculation
    
    for (int i = 0; i < timeArr.length; i++){
      timeArr[i].trim();
    }
    
    int hours = int(timeArr[0]);
    int minutes = int(timeArr[1]);
    int seconds = int(timeArr[2]);
    int milliseconds = int(timeArr[3]);
    
    t = t + hours*3600000;
    t = t + minutes*60000;
    t = t + seconds*1000;
    t = t + milliseconds;
    
    return t;
  }
  void printSubtitle(StringList subtitle) {
    //for (int i = 0; i < subtitle.size(); i++){
    //  println(subtitle.get(i));
    //}
    //Get the time line - the first element in subtitle
    String timeLine = subtitle.get(0);
    //Find the position of the arrow (-1 if not found - but it should be there)
    int arrowPos = timeLine.indexOf(arrow);
    //Get the string to the left of the arrow - that's the start time
    String t1Str = timeLine.substring(0, arrowPos);
    t1Str.trim();
    //Get the string to the right of the arrow - that's the end time
    String t2Str = timeLine.substring(arrowPos + arrow.length() + 1, timeLine.length());
    t2Str.trim();
    //Split the start time on tokens, creating an array of strings
    String [] startTimeArr = splitTokens(t1Str, tokens);
    //Split the end time on tokens, creating another array of strings
    String [] endTimeArr = splitTokens(t2Str, tokens);
    int t1 = parseTime(startTimeArr);  //Start time
    int t2 = parseTime(endTimeArr);    //End time

    println("Start time:", t1, "End time:", t2);
    //Print the text lines in the subtitle StringList
  }
}
