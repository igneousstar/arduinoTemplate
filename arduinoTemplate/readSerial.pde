void readSerial() {
  if (myPort.available() > 0) {
    dataIn = myPort.readStringUntil('\n');
  } 

  if (str != null) {
    try{
      String[] split;
      split = dataIn.split(",");
      for(int i = 0; i < dataSize && i < split.length; i++){
        serialData[i] = parseFloat(split[i]);
        //Use this for debugging
        //print("" + serialData[i] + " ");
      }
      //this too
      //println()
    }
    catch(Exception e){print("something went wrong trying to read the serial data");}
  }
}
