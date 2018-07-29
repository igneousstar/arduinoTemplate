/**
 * all the pins being used
 */
#define LED1 13
#define LED2 9
#define PHOTO_RESISTOR A0

//Change this to send more data
//to the computer
#define OUT_DATA_SIZE 3

//Change this to recieve
//more data from the computer
#define IN_DATA_SIZE 2

//Variables used to send data
float outGoingData[OUT_DATA_SIZE];

//The data coming from the computer
int inComingData[IN_DATA_SIZE];

void setup() {
  //get rid of null values
  for(int i = 0; i < OUT_DATA_SIZE; i++){
    outGoingData[i] = 0;
  }
  Serial.begin(9600);
  pinMode(LED1, OUTPUT);
  pinMode(LED2, OUTPUT);
  pinMode(PHOTO_RESISTOR, INPUT);
}

void loop() {
  //first, read the new data
  readData();

  //read all the sensors and set outgoing data
  outGoingData[0] = analogRead(PHOTO_RESISTOR);
  
  //change the Value of the LED
  //or do anything else with the 
  //expected inComingData[]
  if(inComingData[0] > 0){
    digitalWrite(LED1, HIGH);
  }
  else{
    digitalWrite(LED1, LOW);
  }
  
  analogWrite(LED2, inComingData[1]);
  
  
  //Send data to the computer
  sendData();
  delay(5);
}

/**
 * sends data to the computer
 */
void sendData(){
  //start the string with the first value
  String outGoingString = "";
  for(int i = 0; i < OUT_DATA_SIZE; i++){
    outGoingString = outGoingString + outGoingData[i];
    outGoingString = outGoingString + ",";
  }
  Serial.println(outGoingString);
}

/**
 * read the incoming data
 * from the computer
 */
void readData(){  
     //find the starting point 
     //of the incoming string
     if (Serial.find("aa")) {
      for(int i = 0; i < IN_DATA_SIZE; i++){
        inComingData[i] = Serial.parseInt();
      }
     }
}




