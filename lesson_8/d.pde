class DNA {
  
  PVector[] genes;
  float maxforce = 0.1;
  
  DNA(){
    genes=new PVector[lifetime];
    for (int i=0;i<genes.length;i++){
      genes[i]=new PVector(cos(random(TWO_PI)),sin(random(TWO_PI)));
      genes[i].mult(random(g,maxforce));//用随机方式改变向里长度，但不要超过最大推进力
    }
 genes[0].normalize();
 ｝

//1.交叉功能
  DNA crossover(DNA partner）{  //交叉
    PVector[] child = new PVector[genes.length];  //下一代基因数里设置
    int crossover =int(random(genes.length));     //丛基因中随机提取1个
    for (int i=0;i<genes.length;i++){
      if (i > crossover) child[i]=genes[i];
      else child[i]=partner.genes[i];
    }
    DNA newgenes = new DNA(child);
    return newgenes;
  }
  
//2.变异功能
  void mutate(float m){   //变异
    for (int i=0;i<genes.length;i++){
      if (random(1)<m){
        genes[i]=new PVector(cos(random(TWo PI)),sin(random(TWo_PI)));
        genes[i].mult(random(0,maxforce));
        if (i==0) genes[i].normalize();
      }
    }
  }
//3,新基因代替老基因
  DNA(PVector[]newgenes){
    genes = newgenes;
  }
  
}
