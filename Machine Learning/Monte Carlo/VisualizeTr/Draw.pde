// places.length = 30
// places[0].length = 60
import gifAnimation.*;
GifMaker gifExport;

color[] cars = {#374015, #024059, #F23005, #A61103, #90ADB8};
color[] amer = {#36312F, #0020AB, #DE0900, #E8C000, #FF5800};
color[] two = {#731022, #A88A59, #AAB5BF, #2685BF, #594E45, #101013};
color[] palette = {};

float max = 895.0;
float wide = 1200.0;
float mult = 7.0;
int big = 30;
int iter = 0;

void setup() {
  background(220);
  size(int(wide), 500);
  smooth();
  
  stroke(0);
  strokeWeight(12);
  fill(0);
  
  frameRate(7);
//  print(mult);
  for (int i = 0; i < 50; i++) {
    palette = append(palette, two[int(random(5))]);
  }
  
  
  gifExport = new GifMaker(this, "MonteCarloRoad.gif");
  gifExport.setRepeat(0); // make it an "endless" animation
//  gifExport.setTransparent(255); // make white the transparent color -- match browser bg color
  gifExport.setDelay(1000/7);  //7fps in ms
  
}

void draw() {
  background(#202A34);
  stroke(#F2C12E);
  int std = 15;
  float mov = 1.5;
  line(0, mov*(height/2)-std, width, mov*(height/2)-std);
  line(0, mov*(height/2)+std, width, mov*(height/2)+std);
  for (int i = 0; i < 50; i++) {
    stroke(palette[i]);
    fill(palette[i]);
    ellipse(mult * monteCarlo[i][iter], height/3, big, big); 
  }
  if (iter < 199) iter += 1;
  gifExport.addFrame();
  if (frameCount == 7*17) gifExport.finish();
}

