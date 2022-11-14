ArrayList<Boid> boids = new ArrayList<Boid>(); 
ArrayList<Predator> preds = new ArrayList<Predator>(); 
int boidNum = 10; 
int predNum = 2;
PVector mouse; 
float obstRad = 60; 
int boolT = 0; 
boolean flocking = true; 
boolean arrow = true; 
boolean circle = false;
boolean predBool = true; 
boolean obsBool = false; 


void setup() {
  size(800, 400);
  smooth();
  for (int i=0; i<boidNum; i++) { 
    boids.add(new Boid(new PVector(random(0, width), random(0, height))));
  }
  for (int j=0; j<predNum; j++) { 
    preds.add(new Predator(new PVector(random(0, width), random(0, height)), 50));
  }
}

void draw() {
  fill(255, 249, 240, 90);
  noStroke();
  rect(0, 0, width, height);
  fill(80, 20, 50);
  text("Boids:", 10, 10);
  text(boids.size(), 50, 10);
  if (mousePressed) { 
    boids.add(new Boid(new PVector(mouseX, mouseY)));
  }

  for (Boid boid: boids) { 
    if (predBool) { 
      for (Predator pred: preds) { 
        PVector predBoid = pred.getLoc();
        boid.repelForce(predBoid, obstRad);
      }
    }
    if (obsBool) { 
      mouse = new PVector(mouseX, mouseY);
      boid.repelForce(mouse, obstRad);
    }
    if (flocking) { 
      boid.flockForce(boids);
    }    
    boid.display(circle, arrow); 
    
  }
  for (Predator pred: preds) {
    if (flocking) { 
      pred.flockForce(boids);
      for (Predator otherpred: preds){ 
        if (otherpred.getLoc() != pred.getLoc()){
          pred.repelForce(otherpred.getLoc(), 30.0);
        }
      }
    }
    pred.display();
  }
 saveFrame();
}


class Boid {
  PVector loc;
  PVector vel;
  PVector acc;
  int mass; 
  int maxForce = 6;
  Boid(PVector location) {
    loc = location;
    vel = new PVector();
    acc = new PVector();
    mass = int(random(5, 10));
  }



  void flockForce(ArrayList<Boid> boids) {
    avoidForce(boids);
    approachForce(boids);
    alignForce(boids);
  }

  void update() {
    vel.add(acc);
    loc.add(vel);
    acc.mult(0);
    vel.limit(5); 
    if (loc.x<=0) {
      loc.x = width;
    }
    if (loc.x>width) {
      loc.x = 0;
    }
    if (loc.y<=0) {
      loc.y = height;
    }
    if (loc.y>height) {
      loc.y = 0;
    }
  }

  void applyF(PVector force) {
    force.div(mass);
    acc.add(force);
  }

  void display(boolean circle, boolean arrow) {
    update();
    fill(0, 0);
    stroke(0);
    if (circle) {
      ellipse(loc.x, loc.y, mass, mass); 
    }
    if (arrow) {
      line(loc.x, loc.y, loc.x + 3*vel.x, loc.y + 3*vel.y);
    }
  }

  void displayCircle() {
    ellipse(loc.x, loc.y, mass, mass); 
  }
  void displayArrow() {
    line(loc.x, loc.y, loc.x + 3*vel.x, loc.y + 3*vel.y);
  }

  void avoidForce(ArrayList<Boid> boids) { 
    float count = 0; 
    PVector locSum = new PVector(); 
    for (Boid other: boids) {
      int separation = mass + 20; 
      PVector dist = PVector.sub(other.getLoc(), loc); 
      float d = dist.mag();
      if (d != 0 && d<separation) { 
        PVector otherLoc = other.getLoc();
        locSum.add(otherLoc); 
        count ++;
      }
    }
    if (count>0) { 
      locSum.div(count);
      PVector avoidVec = PVector.sub(loc, locSum); 
      avoidVec.limit(maxForce*2.5); 
      applyF(avoidVec);
    }
  }

  void approachForce(ArrayList<Boid> boids) {
    float count = 0; 
    PVector locSum = new PVector(); 
    for (Boid other: boids) {
      int approachRadius = mass + 60; 
      PVector dist = PVector.sub(other.getLoc(), loc);
      float d = dist.mag();
      if (d != 0 && d<approachRadius) {
        PVector otherLoc = other.getLoc();
        locSum.add(otherLoc);
        count ++;
      }
    }
    if (count>0) {
      locSum.div(count);
      PVector approachVec = PVector.sub(locSum, loc);
      approachVec.limit(maxForce);
      applyF(approachVec);
    }
  }

  void alignForce(ArrayList<Boid> boids) {
    float count = 0; 
    PVector velSum = new PVector(); 
    for (Boid other: boids) {
      int alignRadius = mass + 100;
      PVector dist = PVector.sub(other.getLoc(), loc);
      float d = dist.mag();

      if (d != 0 && d<alignRadius) {
        PVector otherVel = other.getVel();
        velSum.add(otherVel);
        count ++;
      }
    }
    if (count>0) {
      velSum.div(count);
      PVector alignVec = velSum;
      alignVec.limit(maxForce);
      applyF(alignVec);
    }
  }


  void repelForce(PVector obstacle, float radius) {
  PVector futPos = PVector.add(loc, vel); 
    PVector dist = PVector.sub(obstacle, futPos);
    float d = dist.mag();
    if (d<=radius) {
      PVector repelVec = PVector.sub(loc, obstacle);
      repelVec.normalize();
      if (d != 0) { 
        float scale = 1.0/d; 
        repelVec.normalize();
        repelVec.mult(maxForce*7);
        if (repelVec.mag()<0) { 
          repelVec.y = 0;
        }
      }
      applyF(repelVec);
    }
  }


  PVector getLoc() {
    return loc;
  }

  PVector getVel() {
    return vel;
  }
}


class Predator extends Boid { 
  float maxForce = 10; 
  Predator(PVector location, int scope) {
    super(location);
    mass = int(random(8, 15)); 
  }

  void display() {
    update();
    fill(255, 140, 130);
    noStroke();
    ellipse(loc.x, loc.y, mass, mass);
  }

  void update() { 
    vel.add(acc);
    loc.add(vel);
    acc.mult(0);
    vel.limit(6); 
    if (loc.x<=0) {
      loc.x = width;
    }
    if (loc.x>width) {
      loc.x = 0;
    }
    if (loc.y<=0) {
      loc.y = height;
    }
    if (loc.y>height) {
      loc.y = 0;
    }
  }

  void approachForce(ArrayList<Boid> boids) { 
    float count = 0;
    PVector locSum = new PVector();

    for (Boid other: boids) {

      int approachRadius = mass + 260;
      PVector dist = PVector.sub(other.getLoc(), loc);
      float d = dist.mag();

      if (d != 0 && d<approachRadius) {
        PVector otherLoc = other.getLoc();
        locSum.add(otherLoc);
        count ++;
      }
    }
    if (count>0) {
      locSum.div(count);
      PVector approachVec = PVector.sub(locSum, loc);
      approachVec.limit(maxForce);
      applyF(approachVec);
    }
  }
}
