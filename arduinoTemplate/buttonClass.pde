class Button extends UIobject{
  
  private String name;
  private int center[];
  
  private int strokeColor;
  private int centerColor;
  private int edgeColor;
  
  private boolean pressed;
  private boolean toggle;
  
  private static final int diameter = 50;
  
  Button(String name, int xPos, int yPos){
    this.name = name;
    center = new int[] {xPos, yPos};
    
    pressed = false;
    
    strokeColor = 0;
    centerColor = #ffffff;
    edgeColor = 0;
  }
  
  void drawUI(){
    strokeWeight(1);
    
    ellipseMode(CENTER);
    
    textAlign(CENTER);
    textSize(12);
    
    fill(centerColor);
    text(name, center[0], center[1] - (diameter - 20));
    
    if(mousePressed && !toggle &&
       (sq(mouseX - center[0]) + sq(mouseY - center[1]) <= sq(diameter)/2)){
      pressed = !pressed;
      
    }
    
    if(pressed){
        stroke(strokeColor);
        
        fill(centerColor);
        ellipse(center[0], center[1], diameter, diameter);
        
        fill(edgeColor);
        ellipse(center[0], center[1], diameter - 10, diameter - 10);
        text("OFF", center[0], center[1] + diameter - 10);
    }
    if(!pressed){
        stroke(strokeColor);
        
        fill(edgeColor);
        ellipse(center[0], center[1], diameter, diameter);
        
        fill(centerColor);
        ellipse(center[0], center[1], diameter - 10, diameter - 10);
        text("ON", center[0], center[1] + diameter - 10);
    }
    toggle = mousePressed;
  }
  
  public float[] getValues(){
    if(pressed == false){
      return new float[] {1};
    }
    else{
      return new float[] {0};
    }
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
    if(value[0] >= 1){
      pressed = true;
    }
    else if(value[0] <= 0){
      pressed = false;
    }    
  }
  
  public void setCenterColor(int centerColor){
    this.centerColor = centerColor;
  }
  
  public void setEdgeColor(int edgeColor){
    this.edgeColor = edgeColor;
  }
  
}
