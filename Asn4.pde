import processing.video.*;

Slider progress = new Slider();
Slider brightness = new Slider();
Slider speed = new Slider();
String vidname = "The Hobbit Trailer Pop-Up - Lord of the Rings Movie.mp4"; //640 x 360
Movie m;
boolean paused = false;
float playSpeed = 1.0;
int position = 0;

void setup() {
  size(640, 460);
  frameRate(30);
  rectMode(CORNERS);
  m = new Movie(this, vidname);
  m.play();

  progress = new Slider(width/2, height - 10, 638, 18);
  progress.setLeftVal(0);
  progress.setRightVal(int(m.duration()));
  
  brightness = new Slider(250, height - 40, 100, 20);
  brightness.setLeftVal(0);
  brightness.setRightVal(200);
  brightness.setValue(100);
  
  speed = new Slider(400, height - 40, 100, 20);
  speed.setLeftVal(1);
  speed.setRightVal(5);
  speed.setValue(1);
}

void draw() {   
  background(0);
  progress.drawBackground();
  brightness.drawBackground();
  speed.drawBackground();
  
  m.speed(playSpeed);  

  image(m,0,0);
  
  PImage img = adjustBrightness(get(), brightness.getValue());
  
  image(img,0,0);
  
  position = int(map(m.time(), 0, m.duration(), progress.getMinX(), progress.getMaxX()));
  progress.updateSlider(position, height - 10);
  
  drawButtons();
    
  drawText();  
    
  if(mousePressed){
    if(mouseX > progress.getMinX() && mouseX < progress.getMaxX())
      progress.updateSlider(mouseX, mouseY);
  }
  
  if(mousePressed){
    if(mouseX > brightness.getMinX() && mouseX < brightness.getMaxX())
      brightness.updateSlider(mouseX, mouseY);
  }
  
  if(mousePressed){
    if(mouseX > speed.getMinX() && mouseX < speed.getMaxX())
      speed.updateSlider(mouseX, mouseY);
      if(playSpeed > 0)
        playSpeed = speed.getValue();
      else playSpeed = speed.getValue() * -1;
  }
}

void movieEvent(Movie m) {
  m.read();
}

void mousePressed(){
  buttonEvents();
}
void buttonEvents(){
  // Play/Pause button
    if(mouseX > 10 && mouseX < 80 && mouseY < height - 30 && mouseY > height - 50){
      if(paused){
        m.play();
        paused = false;
      }
      else{
        m.pause(); 
        paused = true;
      }
    }
    
    // Reverse button
    if(mouseX > 100 && mouseX < 170 && mouseY < height - 30 && mouseY > height - 50){
      playSpeed = -1 * playSpeed;
      m.speed(playSpeed);
    }
    
    // Progress bar
    if(mouseX > progress.getMinX() && mouseX < progress.getMaxX() && mouseY > height-20 && mouseY < height){
      position = int(map(mouseX, progress.getMinX(), progress.getMaxX(), 0, m.duration()));
      m.jump(position);
    }
    
    // Speed bar
    if(mouseX > speed.getMinX() && mouseX < speed.getMaxX() && mouseY > height-50 && mouseY < height - 30){
      if(playSpeed < 0) playSpeed = -1 * speed.getValue();
      else playSpeed = speed.getValue();
      //playSpeed = speed.getValue();
      int temp = int(map(mouseX, speed.getMinX(), speed.getMaxX(), speed.getMinVal(), speed.getMaxVal()));
      speed.updateSlider(temp, height - 40);
    }
    
    // Brightness to be implemented
}

PImage adjustBrightness(PImage source, int percent){
  PImage target = createImage(source.width, source.height, RGB); //Assume they are the same size
  
  for(int y = 0; y < 360; y++){
    for(int x = 0; x < 640; x++){
      color c = source.get(x,y);
      
      float r = red(c), g = green(c), b = blue(c);            
      
      r = .01 * percent * r;
      g = .01 * percent * g;
      b = .01 * percent * b;
      
      target.set(x,y,color(r,g,b));      
    }
  }
  
  return target;
}

void drawButtons(){
  // Play/Pause button
  fill(255);
  rect(10, height - 30, 80, height - 50);
  fill(0);
  text("Play/Pause", 45, height - 40);
  
  // Reverse button
  fill(255);
  rect(100, height - 30, 170, height - 50);
  fill(0);
  text("Reverse", 135, height - 40);
}

void drawText() {
  fill(255);
  text("Brightness", 250, height-60);
  text("Speed", 400, height-60);
}