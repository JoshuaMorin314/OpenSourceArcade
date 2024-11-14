Board B=new Board(8);

void setup(){
  size(600,710);
}

void draw(){
  B.disp();
}

void keyPressed(){
  B.update();
}

void mousePressed(){
  B.update();
}
