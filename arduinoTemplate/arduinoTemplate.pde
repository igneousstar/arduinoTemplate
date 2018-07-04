import processing.serial.*;
import java.util.ArrayList;

/**
* The com port the arduino is on
*/

Serial myPort;

/**
* the incoming String from 
* the Arduino
*/
String dataIn;

/**
* The size of the incoming serial data
* this is what you need to change
* if you modify the amount of data
* being read from the Arduino. 
*/
static final int dataSize = 1;

/**
* The incomeing serial data
*/
float[] serialData;

/**
* A timer for different actions
*/

long timer;

/**
* This is the data that
* is going to be sent to 
* the Arduino :)
*/
String str;

/**
* These are example objects
*/
Slider slider;
Button button;
Graph graph;
Gauge gauge;

void setup(){
  //start the incoming data array
  serialData = new float[dataSize];
  //get rid of all the null pointers
  //in the array
  for(int i = 0; i < dataSize; i++){
    serialData[i] = 0;
  }
  
  /** 
  * this is how to initialize 
  * the example objects
  */ 
  
  /**
  * Creates a Slider object.
  * @param String name, name of Slider
  * @param int centerX, x coordinate
  * @param int centerY, y coordinate
  * @param int sliderLength, length of slider
  * @param int mapMin, min expected value
  * @param int mapMax, max expected value
  * Slider(String name, int centerX, int centerY, int sliderLength, int mapMin, int mapMax)
  */
  slider = new Slider("mySlider", width/2, 100, 600, 0, 255);
  
  /**
  * Creates a button object
  * @param String name is the name
  * @param xPos is x position of the center
  * @param yPos is y position of the center
  * Button(String name, int xPos, int yPos)
  */ 
  button = new Button("myButton", width/2, 200);
  
  /**
  * Constructs a Gauge object by giving:
  * @param name, the name of the Gauge
  * @param centerX, the x coordinate of 
  * the center
  * @param mapMin, the smalles value expected
  * to be recieved
  * @param, mapMax, the max value expected 
  * to be recieved
  * Gauge(String name, int centerX, int centerY, int mapMin, int mapMax)
  */
  gauge = new Gauge("myGauge", width/2, 335, 0, 1023);
  
  /**
  * Creates a graph that displays
  * all the float values[] in 
  * respect to time. 
  * @param name, the name of the graph
  * @param centerX, the x coordinate 
  * @param centerY, the y coordinate
  * @param lineNames[] all the names
  * of the values the graph is going
  * to keep track of. By adding more
  * names to the matrix, you add more 
  * lines.
  * @param maxTime, the amount of time
  * the graph keeps track of in milliseconds
  * Graph(String name, int centerX, int centerY, String[] lineNames, int maxTime)
  */
  
  String lineNames[] = {"line1", "line2"};
  graph = new Graph("myGraph", width/2, 550, lineNames, 70000);
  
  //Set the colors for all the lines in the graph
  int colors[] = {#ff0000, #00ff00};
  graph.setColors(colors);
  
  //start the timer for comSelect
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
  else{
    //read the data
    readSerial();
    
    //set the new values
    //the setValues() requires
    //an array hence having to 
    float[] graphData = {serialData[0], slider.getValues()[0]};
    graph.setValues(graphData);
    gauge.setValues(serialData[0]);
    
    //draw the user interface
    button.drawUI();
    slider.drawUI();
    gauge.drawUI();
    graph.drawUI();
    
    //send the serial data, use the same
    myPort.write("" + button.getValues()[0] + ", " + slider.getValues()[0]);
  }
}
