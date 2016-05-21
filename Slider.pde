class Slider {
  int xpos, ypos;
  int w, h;
  int minX, maxX, minY, maxY;
  int minVal, maxVal;
  int sliderValue;
  int previousX;
  
  // Constructor
  Slider(){
  }
  
  Slider(int ax, int ay, int aw, int ah){
    xpos = ax;
    ypos = ay;
    w = aw;
    h = ah;
    
    minX = xpos - (w/2);
    maxX = xpos + (w/2);
    
    minY = ypos - (h/2);
    maxY = ypos + (h/2);
    
    // Setup the rectangle for slider
    fill(color(255));
    rectMode(CORNERS);
    rect(xpos - (w/2), ypos - (h/2),xpos + (w/2), ypos + (h/2));  
  }
  
  void setLeftVal(int min){
    minVal = min; 
  }
  
  void setRightVal(int max){
    maxVal = max; 
  }
  
  int getMinVal(){
    return minVal; 
  }
  
  int getMaxVal(){
    return maxVal; 
  }
  
  int getMinX(){
    return minX; 
  }
  
  int getMaxX(){
    return maxX; 
  }
  
  int getValue(){
    return sliderValue;
  }
  
  void setValue(int val){
    sliderValue = val;
  }
  
  void drawBackground(){
    //background(0);
    fill(255);
    rect(xpos - (w/2), ypos - (h/2), xpos + (w/2), ypos + (h/2));
    
    fill(0);
    line(previousX, minY, previousX, maxY);    
    
    textSize(12);
    textAlign(CENTER, CENTER);
    text(sliderValue, (maxX+minX)/2, (maxY+minY)/2);     
  }
    
  
  void updateSlider(int x, int y){
    //drawBackground();
    if(x > minX && x < maxX && y > minY && y < maxY){      
      previousX = x;      
      sliderValue = int(map(x, minX, maxX, minVal, maxVal));      
    }
    
    
  }
}