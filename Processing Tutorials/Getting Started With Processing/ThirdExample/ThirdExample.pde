color[] palette = {#1A4F7A, #DC5E4B, #59C0E1, #9BA6B9, #261C1A};

void setup() {
  size(600,200);
  smooth();
  noFill();
  strokeWeight(5);  
};

void draw() {
  float x = random(width);
  float y = random(height);
  float diameter = random(5, 100);
  stroke(palette[(int(random(5)))]);
  ellipse(x,y,diameter,diameter);
};
