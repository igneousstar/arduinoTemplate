import processing.serial.*;
import java.util.ArrayList;

/**
* The com port the arduino is on
*/

Serial myPort;

/**
* A timer for different actions
*/

long timer;

void setup(){
  timer = millis() -3000; 
  size(1400, 700);
  textSize(32);
  background(#044f6f);
}


void draw(){
  background(#044f6f);
  if(myPort == null){
    selectCom();
  }
  
}
