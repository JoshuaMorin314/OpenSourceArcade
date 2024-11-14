class Filler implements Game{
  int[][] player;
  color[][] C;  // colormap
  int size;  // number of rows/columns
  int difficulty=15;  // maximum allowed number of turns 
  int margin=50;  // size of the margins
  int buttons=6;  // number of colors (maximum of 8)
  color bkgd=#FFBABFBA;  // color of the background
  color[] colors={#FF000000,#FF0000FF,#FF00FF00,#FF00FFFF,#FFFF0000,
    #FFFF00FF,#FFFFFF00,#FFFFFFFF}; // potential colors
  color c;  // current color
  int won=-1;  // has the game been won
  int moves;  // number of moves left
  
  
  Filler(int cellsPerSide){
    size=cellsPerSide;
    C=new color[size][size];
    generate();
  }
  
  public void generate(){
    won=-1;
    moves=difficulty;
    // generate board
    for(int i=0; i<size; i++){
      for(int j=0; j<size; j++){
        C[i][j]=colors[floor(random(buttons))]; // select colors
      }
    }
    // set currnet color
    c=C[0][0];
  }
  
  /*
  color generateColor(int numCols){
    // generate color
    String s=binary(floor(random(numCols)),3);
    int[] crd=new int[3];
    for(int k=0; k<3; k++){
      if(s.charAt(k)=='1'){
        crd[k]=255;
      }else{
        crd[k]=0;
      }
    }
    return color(crd[0],crd[1],crd[2]);
  }
  
  // black     0,  0,  0   000 0
  // white   255,255,255   111 7
  // red     255,  0,  0   100 4
  // yellow  255,255,  0   110 6
  // green     0,255,  0   010 2
  // cyan      0,255,255   011 3
  // blue      0,  0,255   001 1
  // magenta 255,  0,255   101 5
  // =>kbgcrmyw
  */
  
  private void floodFlow(color c,int i,int j){
    // recursive break
    if(i==size || j==size){  // || i==-1 || j==-1){
      return;
    }
    // update current tile (needs to be before the tests to prevent doubling back)
    color tc=C[i][j];  // store the old color (for recursive tests)
    C[i][j]=c;  // set to the new color 
    // recursively identify all connected (like color) tiles
    if(i<size-1 && C[i+1][j]==tc){
      floodFlow(c,i+1,j);
    }
    if(j<size-1 && C[i][j+1]==tc){
      floodFlow(c,i,j+1);
    }
    if(i>=1 && C[i-1][j]==tc){
      floodFlow(c,i-1,j);
    }
    if(j>=1 && C[i][j-1]==tc){
      floodFlow(c,i,j-1);
    }
  }
  
  public void disp(){
    background(bkgd);
    noStroke();
    rectMode(CORNER);
    int cellSize=(width-2*margin)/size;
    for(int i=0; i<size; i++){
      for(int j=0; j<size; j++){
        fill(C[i][j]);
        rect(margin+j*cellSize,margin+i*cellSize,cellSize,cellSize);
      }
    }
    // buttons
    int buttonSpace=(width-2*margin)/buttons;
    int buttonSize=floor(0.75*buttonSpace);
    int submargin=margin+floor(0.125*margin);
    for(int i=0; i<buttons; i++){
      fill(colors[i]);
      rect(submargin+i*buttonSpace,cellSize*size+margin*2,buttonSize,buttonSize);
    }
    fill(0);
    textAlign(CENTER,CENTER);
    textSize(16);
    text("NUMBER OF MOVES: "+moves,width/2,height-margin/2);
    if(won!=-1){ // game won
      rectMode(CENTER);
      fill(159);
      rect(width/2,height/2,200,100);
      fill(255,0,0);
      textSize(36);
      text((won>=1)?"YOU WON!!":"GAME OVER",width/2,height/2-25);
      textSize(16);
      text("Press ENTER to play again",width/2,height/2+10);
      text("Press ESCAPE to exit",width/2,height/2+30);
    }
  }
  
  public void update(){
    if(won!=-1){
      if(keyPressed){
        if(key==RETURN || key==ENTER){
          generate();
        }else if(keyCode==ESC){
          exit();
        }
      }
    }else if(mousePressed){
      color tc=get(mouseX,mouseY);
      if(mouseY>width && tc!=bkgd){
        moves--;
        c=get(mouseX,mouseY);
        floodFlow(c,0,0);
        check();
      }
    }
  }
  
  public void check(){
    won=1;
    for(int i=0; i<size*size; i++){
      if(c!=C[floor(i/size)][i%size]){
        won=-1;
      }
    }
    if(moves==0){
      won++;
    }
  }
  
  String toString(){
    String s="";
    for(int i=0; i<size; i++){
      for(int j=0; j<size; j++){
        s=s+" ("+hex(C[i][j],6)+") ";
        if(j<size-1){
          s=s+",";
        }
      }
      s=s+"\n";
    }
    return s;
  }
}
