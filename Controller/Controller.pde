UIScreen G;

void setup(){
  size(600,710);
  G=new Menu();
}

void draw(){
  G.disp();
}

void keyPressed(){
  G.update();
}

void mousePressed(){
  G.update();
}
