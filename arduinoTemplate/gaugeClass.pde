class Gauge extends UIobject{
  
  private int[] center;
  
  private String name;
  
  private float[] value = {0};
  
  private int mapMax;
  private int mapMin;
  
  private int gaugeColor;
  private int backColor;
  
  private static final int diameter = 150;
  
  
  Gauge(String name, int centerX, int centerY, int mapMin, int mapMax){
    this.name = name;
    this.mapMax = mapMax;
    this.mapMin = mapMin;
    this.center = new int[] {centerX, centerY};
    gaugeColor = #ffffff;
    backColor = 0;
    value[0] = (mapMax + mapMin)/2;
  }
  public void setCenter(int centerX,int centerY){
    center = new int[] {centerX, centerY};
  }
  
  public void setValues(float[] value){
    if(value[0] < mapMin){
      this.value[0] = mapMin;
    }
    else if(value[0] > mapMax){
      this.value[0] = mapMax;
    }
    else{
      this.value[0] = value[0];
    }
  }

  public void drawUI(){
    strokeWeight(10);
    stroke(backColor);
    noFill();
    arc(center[0], center[1], diameter, diameter, HALF_PI+QUARTER_PI, 2*PI+QUARTER_PI);
    
    stroke(gaugeColor);
    float stop = map(value[0], mapMin, mapMax, HALF_PI+QUARTER_PI, 2*PI+QUARTER_PI);
    arc(center[0], center[1], diameter, diameter, HALF_PI+QUARTER_PI, stop);
    
    fill(gaugeColor);
    textAlign(CENTER);
    textSize(12);
    
    text(name + ": " + String.format("%.2f", value[0]), center[0], center[1]);
  }
  
  public float[] getValues(){
    return value;
  }
  
  public int[] getCenter(){
    return center;
  }
  
  public String getN(){
    return name;
  }
  
  public void setGaugeColor(int gaugeColor){
    this.gaugeColor = gaugeColor;
  }
  
  //allows you to use fill(int) with the
  // #ffffff rgb format as a single variable
  // this can also be done by bit shifting
  public void setGaugeColor(int r, int g, int b){
    gaugeColor = ((0xff000000 + r*0x10000 + g*0x100 + b) + 0xffffffff) + 1;
  }
  
  public void setGaugeColor(float r, float g, float b){
    int R = (int) r;
    int G = (int) g;
    int B = (int) b;
    gaugeColor = ((0xff000000 + R * 0x10000 + G * 0x100 + B) + 0xffffffff) + 1;
  }
}
