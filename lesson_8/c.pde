class Rocket {
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float fitness;
  DNA dna;
  int geneCounter = 0;
  boolean hitTarget = false；
  float recordDist; //它离目标有多近？
  boolean hitObstacle = false; //与障碍物是否碰撞
  int finishTime;  //结束时间

  Rocket(PVector 1,DNAdna,int totalRockets){
    acceleration = new PVector();
    velocity = new PVector();
    1ocation=l.get();
    r=4;
    dna = dna ;
    finishTime = 0;       //我们要计算达到目标需要多长时间。
    recordDist = 10000;  //一些很快就会被击败的数字

//1.牛顿第二定律
  void applyForce2(PVector f){
    acceleration.add(f);
  }

//2.向量加速度
  void update(){
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    ｝

//3.适应度
  void fitness(){
    if (recordDist < 1) recordDist = 1;
    fitness =(1/(finishTime*recordDist));
    fitness pow(fitness,4);
    if (hitobstacle)fitness *=0.1;
    if (hitTarget)fitness *=2;

//4.火箭外观
  void display(){
    float theta = velocity.heading2D()+PI/2;
    fill(200,100);
    stroke(0);
    pushMatrix();
      translate(location.x,location.y);
      rotate(theta);
      rectMode(CENTER);
      fill(0);
      rect(-r/2,r*2,r/2,r);
      rect(r/2,r*2,r/2,r);
      fill(175);
      beginShape(TRIANGLES);
        vertex(0,-r*2);
        vertex(-r,r*2);
        vertex(r,r*2);
      endShape();
    popMatrix();
  }

//5.水箭坐标与靶子坐标距离检测
  void checkTarget(){
    float d = dist(location.x,location.y,target.location.x,target.location.y);
    if (d < recordDist) recordDist = d;
    if (target.contains(location) && !hitTarget) hitTarget = true;
    else if (!hitTarget)  finishTime++;
  }

//6.火箭坐标与靶子坐标距离不在指定范围内不断地重复尝试
  void run(ArrayList<Obstacle>os){
    if (!hitObstacle && !hitTarget){
      applyForce2(dna.genes[geneCounter]);
      geneCounter = (geneCounter + 1)%dna.genes.length;
      update();
      obstacles(os);
    }
      if (!hitobstacle){
        display();
      }
  }

//7.--新增功能一-
  void obstacles(ArrayList<Obstacle>os){
    for (Obstacle obs:os){
      if (obs.contains(location)) hitObstacle = true;
    }
  ｝
  float getfitness(){
    return fitness;
    ｝
  DNA getDNA(){
    return dan;
  }
  boolean stopped(){
    return hitObstacle;
  }
  
}
