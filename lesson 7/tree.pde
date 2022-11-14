boolean drawRoof = true;

void setup() {
  size(800, 800);
  fill(0, 150);
  noStroke();
}

void draw() {
  background(255);
  drawHouse(width/2 - 50, width/2 + 50, height/2+150, 10);
  saveFrame();
}

void drawHouse(float x1, float x2, float y, int level) {
  if (level > 0) {
    float w = x2 - x1;
    float w1=w*(mouseX/(float)height);
    float dy = w * (mouseY/(float)width);
    quad(x1, y, x2, y, x2, y-w, x1, y-w);
    
    if (drawRoof) {
      triangle(x1, y-w, x2, y-w, x1+w1, y-w-dy);
    }
    float d1 = dist(x1, y-w, x1+w1, y-w-dy);
    float d2 = dist(x2, y-w, x1+w1, y-w-dy);

    // left branch
    pushMatrix();
    translate(x1, y-w);
    float angle1 = atan(dy/w1);
    rotate(-angle1);
    drawHouse(0, d1, 0, level-1);
    popMatrix();

    // right branch
    pushMatrix();
    translate(x2, y-w);
    float angle2 = atan(dy/(w-w1));
    rotate(angle2);
    drawHouse(-d2, 0, 0, level-1);
    popMatrix();
  }
}

void mousePressed(){
  drawRoof = !drawRoof;
}
