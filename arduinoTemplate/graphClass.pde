import java.util.ArrayList;

class Graph extends UIobject{

  private int[] center;
  
  private String name;
  
  private float[] values;
  
  private int graphHieght;
  private int graphWidth;
  
  private static final int timeSpacing = 50;
  
  long time;
  int maxTime;
  
  int[] lineColors;
  String[] lineNames;
  float[][] lineValues;
  
  Graph(String name, int centerX, int centerY, String[] lineNames, int maxTime){
    time = millis();
    this.name = name;
    this.lineNames = lineNames;
    this.center = new int[] {centerX, centerY};
    this.maxTime = maxTime/timeSpacing;
    
    graphHieght = 200;
    graphWidth = 300;
    
    lineValues = new float[lineNames.length][maxTime];
    lineColors = new int[lineNames.length];
    values = new float[lineNames.length];
    for(int i = 0; i < lineNames.length; i++){
      lineColors[i] = #ffffff;
      values[i] = 0;
      for(int j = 0; j < maxTime; j++){
        lineValues[i][j] = 0;
      }
    }
    
  }
  
  
  void drawUI(){
    
    //Set the new values every 50 milliseconds
    if(millis() > time + timeSpacing){
      time = millis();
      for(int i = 0; i < lineNames.length; i++){
        for(int j = 0; j < maxTime - 1; j++){
          lineValues[i][j] = lineValues[i][j+1];
        }
      }
      for(int i = 0; i < lineNames.length; i++){
        lineValues[i][maxTime-1] = values[i];
      }
    }
    textAlign(CENTER);
    textSize(18);
    fill(#ffffff);
    text(name, center[0], center[1] - graphHieght/2 - 15);
    
    textAlign(LEFT);
    for(int i = 0; i < lineNames.length; i++){
      text(lineNames[i] + ": " + String.format("%.2f", values[i]), center[0] + graphWidth/2 + 5, center[1] - graphHieght/2 + 20*(i+1));
    }
    
    strokeWeight(4);
    stroke(0);
    
    rectMode(CENTER);
    noFill();
    rect(center[0], center[1], graphWidth, graphHieght);
    
    //find max and min values to latter 
    //map them inside of the graph
    float maxHeight = lineValues[0][0];
    float minHeight = lineValues[0][0];
    for(int i = 0; i < lineNames.length; i++){
      for(int j = 0; j < maxTime; j++){
        if(maxHeight < lineValues[i][j]){
          maxHeight = lineValues[i][j];
        }
        if(minHeight > lineValues[i][j]){
          minHeight = lineValues[i][j];
        }
      }
    }
    
    //adds spacing prevents
    //return of NaN when mapped
    minHeight -= 3;
    maxHeight += 3;
    
    
    float xStart = center[0] - graphWidth/2;
    float xSpacing = graphWidth/maxTime;
    float graphBottom = center[1] + graphHieght/2;
    float graphTop = center[1] - graphHieght/2;
    
    strokeWeight(1);
    
    for(int i = 0; i < lineNames.length; i++){
      for(int j = 0; j < maxTime - 1; j++){
        float yStart = map(lineValues[i][j], minHeight, maxHeight, graphBottom, graphTop);
        float yStop = map(lineValues[i][j+1], minHeight, maxHeight, graphBottom, graphTop);
        
        stroke(lineColors[i]);
        line(xStart+j*xSpacing, yStart, xStart+(j+1)*xSpacing, yStop);
        
      }
    }
    
    
  }
  
  
  public void setCenter(int centerX,int centerY){
    center = new int[] {centerX, centerY};
  }
  
  public void setValues(float values[]){
    try{
      for(int i = 0; i < values.length; i++){
        this.values[i] = values[i];
      }
    }
    catch(Exception e){
      println("graphClass setValues");
    }
  }
  
  public float[] getValues(){
    return values;
  }
  
  public int[] getCenter(){
    return center;
  }
  
  public String getN(){
    return name;
  }
  
  public void setColors(int[] colors){
    if(colors.length == lineColors.length){
      for(int i = 0; i < lineColors.length; i++){
        lineColors[i] = colors[i];
      }
    }
  }
  
  
}
