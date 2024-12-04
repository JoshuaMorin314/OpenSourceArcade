class Menu implements UIScreen{ 
  String[] games = {"Asteroids","Filler","Pong","Tic-Tac-Toe","Exit"}; 
  int selectedGame = -1; // No game selected initially 
  
  Menu(){
    disp();
  }
  
  public void generate(){}
  
  public void update(){
    if (selectedGame == -1) { // Handle menu clicks 
      for (int i = 0; i < games.length; i++) { 
        if (mouseX > width / 2 - 100 && mouseX < width / 2 + 100 && mouseY > 100 + i * 70 && mouseY < 150 + i * 70) { 
          selectedGame = i; 
        } 
      } 
    } else if (selectedGame == 0) { 
      G=new Asteroids();
    } else if (selectedGame == 1) { 
      G=new Filler(8);
    } else if (selectedGame == 2) { 
      G=new Pong();
    } else if (selectedGame == 3) { 
      G=new TicTacToe();
    } else if (selectedGame == games.length-1) { 
      exit();
    }
  }
  
  public void check(){}
  
  void disp() { 
    background(50, 150, 200); // Light blue background 
    textAlign(CENTER, CENTER); 
    fill(255);
    textSize(32); 
    text("Arcade Menu", width / 2, 50); 
    for (int i = 0; i < games.length; i++) { 
      fill(200); 
      rect(width / 2 - 100, 100 + i * 70, 200, 50); 
      fill(0); 
      textSize(24); 
      text(games[i], width / 2, 125 + i * 70); 
    } 
  } 
}
