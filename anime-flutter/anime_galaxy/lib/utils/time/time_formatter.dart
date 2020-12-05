class TimeFormatter {

  static String secondsToTime(int seconds){
    int h =seconds ~/ 3600 ;
    seconds = seconds % 3600;
    int m = seconds ~/ 60;
    seconds = seconds % 60;

    return ('${h}h:${m}m:${seconds}s');
  }
}
