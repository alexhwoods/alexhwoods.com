// x and y are arrays of points that fit in a 5 x 5 square.
color[] blue = {#628FF4, #F4DBA3, #0B1659, #DBAE13};
color[] night = {#3671BF, #F29A2E, #041E68, #8C4303, #3A1400};
color[] dartboard = {#FEE2D0, #D95753, #528C6F, #0A0002};
color[] monteCarlo = {#D9C781, #B85004, #737885, #362F4C};
color[] palette = monteCarlo;
float centerX = 2.5;
float centerY = 2.5;
int big = 8;
int mult = 700/5;

float distance(float x, float y) {
  return sqrt(pow((centerX - x), 2) + pow((centerY - y), 2));
}

void setup() {
  background(palette[0]);
  size(700, 700);
  smooth();

  // circle
  stroke(palette[3]);
  noFill();
  strokeWeight(3);
  ellipse(height/2, width/2, 700, 700);

  // points
  for (int i = 0; i < x.length; i++) {
    if (distance(x[i], y[i]) < 2.5) {
      stroke(palette[1]);
      fill(palette[1]);
    }
    else {
      stroke(palette[2]);
      fill(palette[2]);
    }
    smooth();
    ellipse(x[i]*mult, y[i]*mult, big, big);
    
  }
  
}




