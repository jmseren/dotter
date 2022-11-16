boolean ready = false;
boolean first = false;
PImage img;
color white;

int its = 200;
int deviation = 10;

int transparency = 10;

int weight = 6;

void setup(){
   size(1024, 1024);
   background(0);
   selectInput("Image", "imageSelected");
   smooth(8);
   strokeWeight(weight);
   strokeCap(ROUND);

}

void imageSelected(File f){
  
  img = loadImage(f.getAbsolutePath());
  white = img.get(0,0);
  
  ready = true;
  
  
}

boolean closeEnough(color c1, color c2){
  float r1 = red(c1);
  float r2 = red(c2);
  float b1 = blue(c1);
  float b2 = blue(c2);
  float g1 = green(c1);
  float g2 = green(c2);
  
  
  if(abs(r1 - r2) > deviation) return false;
  if(abs(g1 - g2) > deviation) return false;
  if(abs(b1 - b2) > deviation) return false;
  return true;
  
  
   
}



int remapX(int x){
  return (int)lerp(0, width, (float)x / (float)img.width);
}
int remapY(int y){
  return (int)lerp(0, height, (float)y / (float)img.height);
}

int mapX(int x){
  return (int)lerp(0, img.width, (float)x / (float)width);
}
int mapY(int y){
  return (int)lerp(0, img.height, (float)y / (float)height);
}

void draw() {
  if(!ready) return;
  if(first){
    image(img, 0, 0, width, height);
    filter(GRAY);
    first = false;
  }
  strokeWeight(weight);
  for(int i = 0; i < its; i++){
    int x1 = (int)random(img.width + 1);
    int y1 = (int)random(img.height + 1);
    int x2 = (int)random(img.width + 1);
    int y2 = (int)random(img.height + 1);
    
    color c1 = img.get(x1, y1);
    color c2 = img.get(x2, y2);
      
    
    if(closeEnough(c1, c2)){
      stroke(red(c1), green(c1), blue(c1), transparency);
      line(remapX(x1), remapY(y1), remapX(x2), remapY(y2));
      stroke(c1);
      point(remapX(x1), remapY(y1));
      stroke(c2);
      point(remapX(x2), remapY(y2));
    }
  }
  
}

void keyPressed(){
  if(key == ' '){
    ready = !ready;
  }
  if(key == 'c'){
    background(0);
  }
  if(key == '\n'){
    save("export_" + ((int)random(8999) + 1000) + ".png");
  }
  if(keyCode == UP){
    weight++;
  }else if(keyCode == DOWN){
    weight--;
  }else if(keyCode == RIGHT){
    transparency++;
  }else if(keyCode == LEFT){
    transparency--;
  }
}
