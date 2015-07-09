color[] jellyfish = {#0B91CE, #0A41C2, #9691FF, #E0DDCE, #B587B8};



void setup() {
  size(1200, 800);
  background(240);
  smooth();
  noFill();
}

void draw() {
  stroke(jellyfish[int(random(5))]);
  int x = int(random(width+200, width+800));
  int y = int(random(2*height/5, 3*height/5));
//  int cpX1 = int(random(0, 200));
//  int cpY1 = int(random(height));
  int cpX1 = 0;
  int cpY1 = height/2;
  int cpX2 = int(random(0, 200));
  int cpY2 = int(random(height));
  
  beginShape();
  vertex(40, height/2);    // for the first point!
  bezierVertex(cpX1, cpY1, cpX2, cpY2, x, y);
  endShape(); 

}
