class Slider extends UIobject{
  
  private String name;
  
  private int[] barPos;
  
  private int[] center;
  
  private int sliderLength;
  private int sliderHeight = 6;

  private int dragBarLength = 10;
  private int dragBarHeight = 50;
  
  private int mapMin;
  private int mapMax;
  
  private float[] value = {0};
  
  private int prevFrame;
  private int currentFrame;
  
  private int fillColor;
  private int strokeColor;
  
  public Slider(String name, int centerX, int centerY, int sliderLength, int mapMin, int mapMax){
    this.name = name;
    center = new int[] {centerX, centerY};
    barPos = new int[] {centerX, centerY};
    this.sliderLength = sliderLength;
    this.mapMin = mapMin;
    this.mapMax = mapMax;
    
    int xMax = center[0] + sliderLength/2;
    int xMin = center[0] - sliderLength/2;
    value[0] = map(barPos[0], xMin, xMax, mapMin, mapMax);
    prevFrame = mouseX;
    
    fillColor = #ffffff;
    strokeColor = 0;
  }
  
  public void setSliderHeight(int sliderHeight){
    this.sliderHeight = sliderHeight;
  }
  
  public void setSliderLength(int sliderLength){
    this.sliderLength = sliderLength;
  }
  
  public void setDragBarLength(int dragBarLength){
    this.dragBarLength = dragBarLength;
  }
  
  public void setDragBarHeight( int dragBarHeight){
    this.dragBarHeight = dragBarHeight;
  }
  
  public void drawUI(){
    strokeWeight(1);
    
    rectMode(CENTER);
    
    int xMax = center[0] + sliderLength/2;
    int xMin = center[0] - sliderLength/2;
    
    //Sometimes the mouse is dragged faster than the
    //frames refresh. This makes it easier to drag to
    //max or min values
    currentFrame = mouseX;
    int mouseV = abs(prevFrame - currentFrame);
    prevFrame = mouseX;
    
    int yThresh = dragBarHeight/2;
    
    prevFrame = mouseX;
    
    
    if(mousePressed == true){
      if(mouseX < xMax + mouseV && mouseX > xMin - mouseV){
           if(mouseY < barPos[1] + yThresh && mouseY > barPos[1] - yThresh){
              barPos[0] = mouseX;
          }
        }
      }
       
    if(barPos[0] > xMax){
      barPos[0] = xMax;
    }
    else if(barPos[0] < xMin){
      barPos[0] = xMin;
    }
    
    value[0] = map(barPos[0], xMin, xMax, mapMin, mapMax);
    
    fill(fillColor);
    stroke(strokeColor);
    rect(center[0], center[1], sliderLength, sliderHeight);
    rect(barPos[0], barPos[1], dragBarLength, dragBarHeight);
    
    textAlign(CENTER);
    textSize(20);
    
    text(name + ": " + String.format("%.2f", value[0]), center[0], center[1] - 40);
    
  }
  
  public float[] getValues(){
    return value;
  }
  
  void setStroke(int strokeColor){
    this.strokeColor = strokeColor;
  }
  
  void setFill(int fillColor){
    this.fillColor = fillColor;
  }
  
  public String getN(){
    return name;
  }
  
  public void setCenter(int centerX, int centerY){
    center = new int[] {centerX, centerY};
  }
  
  public int[] getCenter(){
    return center;
  }
  
  public void setValues(float[] value){
    int xMax = center[0] + sliderLength/2;
    int xMin = center[0] - sliderLength/2;
    if(value[0] < mapMin){
      this.value[0] = mapMin;
    }
    else if(value[0] > mapMax){
      this.value[0] = mapMax;
    }
    else{
      this.value[0] = value[0];
    }
    barPos[0] = (int) map(value[0], xMin, xMax, mapMin, mapMax);
  }
}
