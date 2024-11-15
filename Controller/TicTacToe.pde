// modify update
// write display
/*
class TicTacToe implements Game{
  int[][] board=new int[3][3];
  int[] position=new int[3];
  int currentPlayer; // player 1 and player 2
  int won=-1;

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

  public boolean update(String s){ // accepts a string designating the move the player wants to make
    boolean success=true; // return true by default
    s=s.toLowerCase().strip(); // makes everything lowercase and removes any spaces at the beginning or end of the string (should be done already)
    if((s.equals("select") || s.equals("s")) && 0==board[position[0]][position[1]]){ // if the input was select/s and the current position is available
      board[position[0]][position[1]]=currentPlayer; // record the current players number designation at the current board position
      position[2]++; // adds to the number of filled spots
      currentPlayer=(currentPlayer==2)?1:2; // switch player from 1 to 2 or 2 to 1
      if(position[2]<9){
        computerPlayer(); // this is based off of my veeeery loose understanding of minimax but it works better than i thought i could ever accomplish
      }
    }else if((s.equals("up") || s.equals("u")) && position[0]!=0){ // if the input was up/u and the current position is not on the top row
      position[0]-=1; // move the current position one spot up
    }else if((s.equals("down") || s.equals("d")) && position[0]!=2){ // if the input was down/d and the current position is not on the bottom row
      position[0]+=1; // move the current position one spot down
    }else if((s.equals("left") || s.equals("l")) && position[1]!=0){ // if the input was left/l and the current position is not in the leftmost column
      position[1]-=1; // move the current position one spot left
    }else if((s.equals("right") || s.equals("r")) && position[1]!=2){ // if the input was right/r and the current position is not in the rightmost column
      position[1]+=1; // move the current position one spot right
    }else{ // if the input is unrecognised
      success=false; // return false
    }
    return success; // true if the move was successful and false if it wasn't
  }

  public void disp(){
    
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
  
  
  public String toString(){
    String s="Arcade>TicTacToe\n----------------\n";
    for(int i=0; i<3; i++){
      String s0="|";
      String s1="|";
      for(int j=0; j<3; j++){
        String st=" ";
        if(position[0]==i && position[1]==j){
          st="|";
        }
        if(0==board[i][j]){
          s0+=st+"  "+st+"|";
          s1+=st+"  "+st+"|";
        }else if(1==board[i][j]){
          s0+=st+"\\/"+st+"|";
          s1+=st+"/\\"+st+"|"; //weird hyperlink problem
        }else if(2==board[i][j]){
          s0+=st+"/\\"+st+"|"; //weird hyperlink problem
          s1+=st+"\\/"+st+"|";
        }
      }
      s+=s0+"\n"+s1+"\n----------------\n";
    }
    if(-1==check()) {
      s+="It's a cat! Neither player wins.";
    }else if(0==check()){
      s+="type the words left, right, up, or down followed by the enter key to move to your desired spot\ntype select followed by the enter key to select a spot at which to play \nPlayer "+currentPlayer+": ";
    }else{
      s+= "Player "+check()+" wins!!!";
    }
    return s;
  }
}
*/
