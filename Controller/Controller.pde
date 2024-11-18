Game G;

void setup(){
  size(600,710);
  G=new Filler(8);
  G=new Asteroids();
  //G=new TicTacToe;
}

void draw(){
  G.disp();
  G.update();
}

void keyPressed(){
  G.update();
}

void mousePressed(){
  G.update();
}
