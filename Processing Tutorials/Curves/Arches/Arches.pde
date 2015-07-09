color[] atlas = {#59AEE1, #7A102D, #1581C4, #C6B32E, #1581C4, #7A102D, #59AEE1};

void setup() {
  size(800,525);
  smooth();
  background(180);
  noFill();
};

void draw() {
  stroke(atlas[int(random(7))]);
  strokeWeight(2);
  
//  int x = 50*(int(random(17)));
  int w = 100*int(random(1, 9));
  int w = 100*5;                // another cool option!
  arc(x, 450, w, 750, PI, 2*PI);
  
  
  stroke(#FFFFFF);             // stroke = white   
  strokeWeight(14);
  
//  These are the white points. 
  for (int i = 50; i <= 800; i = i + 50) {      //0 - 800 increment by 50
    point(0, 450);
    point(i, 450);
  }
};
