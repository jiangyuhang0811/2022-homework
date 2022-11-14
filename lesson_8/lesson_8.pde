int lifetime;
Population population;
int lifecycle;
int recordtime;
obstacle target;
ArrayList<Obstacle> obstacles;
　　
void setup(){
　size(800,200);
　smooth();
　ifetime=300;//生命期
　lifecycle =0;
　recordtime lifetime; 
　target new Obstacle(width/2-12,24,24,24);
　float mutationRate =0.01;
　population new Population(mutationRate,50);
　obstacles new ArrayList<Obstacle>();
　obstacles.add(new Obstacle(300,height/2,width-600,10));
}
　　
void draw(){
　background(255);
　target.display();

　if (lifecycle lifetime)
　　population.live(obstacles);
　　if ((population.targetReached())&&(lifecycle < recordtime)){
     recordtime = lifecycle;
　　}
　　lifecycle++;
　}
　else{
　　lifecycle =0;
　　population.fitness();//火箭适应度
　　population.selection();//火箭选择
　　population.reproduction();//火箭繁殖
　}

　　for (Obstacle obs obstacles){
　　  obs.display();
　　}

　　fil1(0);
　　text("child #:"population.getGenerations(),10,18);
　　text("round:"+(lifetime-lifecycle),10,36);
　　text("Record cyc1es:"+recordtime,10,54);
　　}
　　
void mousePressed(){  //鼠标位置为靶子位置
　　target.location.x = mouseX;
　　target.location.y = mouseY
　　recordtime = lifetime;
}
