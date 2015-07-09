color[] atlas = {#59AEE1, #7A102D, #1581C4, #C6B32E, #1581C4, #7A102D, #59AEE1};
PFont f;

void setup() {
  size(350,300);
  smooth();
  background(210);
  f = createFont("Menlo", 16, true);
    // text!
  textFont(f, 16);
  fill(0);
  text("P1", 55, 200);
  text("P2", 265, 250);
  text("C1", 115, 50);
  text("C2", 305, 110);

};


void draw() {
  stroke(atlas[4]);
  strokeWeight(1);

  int x1 = 90;
  int y1 = 200;
  
  int cpX1 = 150;
  int cpY1 = 50;
  
  int x2 = 250;
  int y2 = 240;
  
  int cpX2 = 290;
  int cpY2 = 100;
  

  
  noFill();
  // lines!
  stroke(#00688B);
  strokeWeight(1);
//  line(x1, y1, cpX2, cpY2);
  line(x1, y1, cpX1, cpY1);
  stroke(#63D1F4);
//  line(x2, y2, cpX1, cpY1);
  line(x2, y2, cpX2, cpY2);
  
  // curve!
  stroke(#ffff00);
  strokeWeight(2);
//  curve(cpX1, cpY1, x1, y1, x2, y2, cpX2, cpY2);
  bezier(x1, y1, cpX1, cpY1, cpX2, cpY2, x2, y2);
  
  // points!
  stroke(#ff0000);
  strokeWeight(10);
  point(x1, y1);
  point(x2, y2);
  
  // control points!
  stroke(255);
  point(cpX1, cpY1);
  point(cpX2, cpY2);
  
}
  
