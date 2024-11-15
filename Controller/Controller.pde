Game G;

void setup(){
  size(600,710);
  G=new Filler(8);
  //G=new TicTacToe;
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
