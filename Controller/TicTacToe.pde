// player switching has bugs
// check doesnt work

class TicTacToe implements Game, UIScreen{
  int[][] board=new int[3][3];
  int[] position=new int[3];
  int currentPlayer; // player 1 and player 2
  int won=-1;
  int margin=20;
  int w=(width-2*margin)/3;
  int h=(height-2*margin)/3;
  int t=millis();

  public TicTacToe(){
    generate();
  }
  
  void generate(){
    for(int i=0; i<3; i++){
      position[i]=0;
      for(int j=0; j<3; j++){
        board[i][j]=0;
      }
    }
    currentPlayer=1;
  }
  
  public void update(){
    PVector mouse=new PVector(mouseX,mouseY);
    for(int i=0; i<3; i++){
      for(int j=0; j<3; j++){
        //if(0<=sq(margin+(j+0.5)*w-mouseX)+sq(margin+(i+0.5)*h-mouseY)-sq((w+h)*3/8)){
        if(((w+h)*3/8)>=mouse.copy().dist(new PVector(margin+(0.5+i)*w,margin+(0.5+j)*h))){
          if(board[i][j]==0){
            board[i][j]=currentPlayer;
            position[2]++; // adds to the number of filled spots
            currentPlayer=(currentPlayer==1)?2:1; // switch player
            if(position[2]<9){
              computerPlayer(); // minmax algorithm
            }
          }
          return;
        }
      }
    }
  }

  public void disp(){
    background(127);
    strokeWeight(5);
    noFill();
    int lw=9*w/10;
    int lh=9*h/10;
    translate(margin,margin);
    for(int i=0; i<3; i++){
      if(i!=0){
        line(i*w,0,i*w,3*h);
        line(0,i*h,3*w,i*h);
      }
      for(int j=0; j<3; j++){
        if(1==board[i][j]){
          line((0.05+i)*w,(0.05+j)*h,(0.05+i)*w+lw,(0.05+j)*h+lh);
          line((0.05+i)*w,(0.05+j)*h+lh,(0.05+i)*w+lw,(0.05+j)*h);
        }else if(2==board[i][j]){
          ellipse(w/2+i*w,h/2+j*h,lw,lh);
        }
      }
    }
  }

  public void check(){
    if(position[2]<=5){
      won=0;
      return;
    }else{
      int w=0;
      int p=1;
      while (p<3 && w==0){
        if(board[1][1]==p && ((board[0][0]==p && board[2][2]==p) || (board[2][0]==p && board[0][2]==p))){
          w=p;
        }else{
          int i=0;
          while (i<3 && w==0){
            if ((board[i][0]==p && board[i][1]==p && board[i][2]==p) || (board[0][i]==p && board[1][i]==p && board[2][i]==p)){
              w=p;
            }
            i++;
          }
        }
        p++;
      }
      if(w==0 && position[2]==9){
        w=3; //cat
      }
      won=w;
    }
  }

  private void computerPlayer(){
    int[][] copy=board;
    ArrayList<Integer[]> empty=new ArrayList<Integer[]>();
    for(int i=0; i<3; i++){
      for(int j=0; j<3; j++){
        if(copy[i][j]==0){
          Integer[] t={i,j};
          empty.add(t);
        }
      }
    }
    Integer[] bestMove=empty.get(bestMove(copy,empty,2)[1]);
    board[bestMove[0]][bestMove[1]]=2;
    position[2]++;
    currentPlayer=1;
  }

  private int[] bestMove(int[][] b, ArrayList<Integer[]> e, int pn){
    int[] result={0,0};
    int n=e.size();
    int w=check(b,n);
    if(n==0){
      return result;
    }
    if(2==w){
      result[0]=1;
    }else if(-1==w){
      result[0]=0;
    }else if(1==w){
      result[0]=-1;
    }else{
      int[] ranks=new int[n];
      for(int i=0; i<n; i++){
        Integer[] t=e.get(i);
        e.remove(i);
        b[t[0]][t[1]]=pn;
        ranks[i]=bestMove(b,e,(pn%2)+1)[0]; // results should take the entire list into account not just the best case
        e.add(i,t);
        b[t[0]][t[1]]=0;
      }
      int m=0;
      for(int i=1; i<ranks.length; i++){
        if((pn==2 && ranks[m]<=ranks[i]) || (pn==1 && ranks[m]>=ranks[i])){
          m=i;
        }
      }
      result[0]=ranks[m];
      result[1]=m;
    }
    return result;
  }

// This is a specialized version of check that takes parameters instead of using the fields so that the program can
//   explore what moves lead to a win without actually changing the fields
  private int check(int[][] b,int e){
    int n=9-e;
    if(n<=5){
      return 0;
    }else{
      int w=0;
      int p=1;
      while (p<3 && w==0){
        if(b[1][1]==p && ((b[0][0]==p && b[2][2]==p) || (b[2][0]==p && b[0][2]==p))){
          w=p;
        }else{
          int i=0;
          while(i<3 && w==0){
            if((b[i][0]==p && b[i][1]==p && b[i][2]==p) || (b[0][i]==p && b[1][i]==p && b[2][i]==p)) {
              w=p;
            }
            i++;
          }
        }
        p++;
      }
      if(w==0 && n==9){
        w=3; //cat
      }
      return w;
    }
  }
}
