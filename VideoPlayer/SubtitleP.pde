class SubtitleP {
  String arrow = "-->";  //Arrow separating start time from end time
  String tokens = ":,";
  String[] lines;
  StringDict subtitle = new StringDict();
  
  SubtitleP(String fname) {
    lines = loadStrings(fname);
    int i = 0;
    while (i < lines.length){
      //if there is an arrow there is a new subtitle
      if(lines[i].contains(arrow)){
        String strKey = lines[i];
        String strVal = "";
        //while the next line is not empty
        //increment i and add it to subtitle StringList
        if(lines[i+2].length() > 0){
          int j = 0;
          while(lines[i+1].length() > 0){
            //for first iteration
            //to stop unnecessary "\n"
            if(j == 0){
              strVal = lines[++i];
              j++;
            }else{
            //splits new lines with "\n" 
            //and concatenates subtitle text
            strVal = strVal + "\n" + lines[++i];
            }
          }
        }else{
          while(lines[i+1].length() > 0){
            //If there is only one line during time interval
            strVal = lines[++i];
          }
        }
        subtitle.set(strKey, strVal);
      }
      i++;
    }
  }
  
  String[] createStartTimeArr(String timeLine){
    //Find the position of the arrow (-1 if not found - but it should be there)
    int arrowPos = timeLine.indexOf(arrow);
    
    //Get the string to the left of the arrow - that's the start time
    String t1Str = timeLine.substring(0, arrowPos);
    t1Str.trim();
    
    //Split the start time on tokens, creating an array of strings
    String [] startTimeArr = splitTokens(t1Str, tokens);
    
    return startTimeArr;
  }
  
  String[] createEndTimeArr(String timeLine){
    //Find the position of the arrow (-1 if not found - but it should be there)
    int arrowPos = timeLine.indexOf(arrow);
    
    //Get the string to the right of the arrow - that's the end time
    String t2Str = timeLine.substring(arrowPos + arrow.length() + 1, timeLine.length());
    t2Str.trim();
    
    //Split the end time on tokens, creating another array of strings
    String [] endTimeArr = splitTokens(t2Str, tokens);
    
    return endTimeArr;
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
}
