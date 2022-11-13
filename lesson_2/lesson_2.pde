void setup() 
{ 
  size(800, 600); 
  noFill(); 
  stroke(255); 
  background(0); 
  frameRate(12); 
} 
 
int res = 50;   
 
void draw() 
{ 
  background(0); 
  for(int i=0; i<height; i+=res) { 
    for(int j=0; j<width; j+=res) { 
      int r = int(random(2)); 
      if(r == 0) { 
       line(j,i,j+res,i+res); 
      } else if (r == 1) { 
        line(j+res,i,j,i+res);     
      } 
    } 
  } 
  saveFrame();
} 
 

 
