 

String[] games = {"Tic-Tac-Toe", "Exit"}; 

int selectedGame = -1; // No game selected initially 

  

void setup() { 
  
  size(600, 400); // Set the canvas size 

} 

  

void draw() { 

  background(50, 150, 200); // Light blue background 

  

  if (selectedGame == -1) { 

    drawMenu(); 

  } else if (selectedGame == 0) { 

    ticTacToeDraw(); 

  } 

} 

  

void drawMenu() { 

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

  

void mousePressed() { 

  if (selectedGame == -1) { // Handle menu clicks 

    for (int i = 0; i < games.length; i++) { 

      if (mouseX > width / 2 - 100 && mouseX < width / 2 + 100 && mouseY > 100 + i * 70 && mouseY < 150 + i * 70) { 

        selectedGame = i; 

        if (games[i].equals("Exit")) exit(); 

        if (games[i].equals("Tic-Tac-Toe")) ticTacToeSetup(); 

      } 

    } 

  } else if (selectedGame == 0) { 

    ticTacToeMousePressed(); 

  } 

} 

 

 

 

Class   

 

char[][] grid; 

char currentPlayer; 

boolean gameActive; 

String winner; 

  

void ticTacToeSetup() { 

  grid = new char[][]{{' ', ' ', ' '}, {' ', ' ', ' '}, {' ', ' ', ' '}}; 

  currentPlayer = 'X'; 

  gameActive = true; 

  winner = ""; 

} 

  

void ticTacToeDraw() { 

  background(50, 200, 150); 

  drawTicTacToeGrid(); 

  if (!gameActive) { 

    fill(255, 0, 0); 

    textSize(24); 

    textAlign(CENTER, CENTER); 

    text(winner + " wins! Press any key to restart.", width / 2, height - 50); 

  } 

} 

  

void drawTicTacToeGrid() { 

  stroke(0); 

  for (int i = 1; i < 3; i++) { 

    line(i * width / 3, 0, i * width / 3, height); // Vertical lines 

    line(0, i * height / 3, width, i * height / 3); // Horizontal lines 

  } 

  

  textSize(64); 

  textAlign(CENTER, CENTER); 

  for (int row = 0; row < 3; row++) { 

    for (int col = 0; col < 3; col++) { 

      text(grid[row][col], col * width / 3 + width / 6, row * height / 3 + height / 6); 

    } 

  } 

} 

  

void ticTacToeMousePressed() { 

  if (!gameActive) return; 

  

  int col = mouseX / (width / 3); 

  int row = mouseY / (height / 3); 

  

  if (row < 3 && col < 3 && grid[row][col] == ' ') { 

    grid[row][col] = currentPlayer; 

    if (checkWinner(currentPlayer)) { 

      winner = str(currentPlayer); 

      gameActive = false; 

    } else if (isGridFull()) { 

      winner = "No one"; 

      gameActive = false; 

    } else { 

      currentPlayer = (currentPlayer == 'X') ? 'O' : 'X'; 

    } 

  } 

} 

  

boolean checkWinner(char player) { 

  for (int i = 0; i < 3; i++) { 

    if (grid[i][0] == player && grid[i][1] == player && grid[i][2] == player) return true; // Rows 

    if (grid[0][i] == player && grid[1][i] == player && grid[2][i] == player) return true; // Columns 

  } 

  if (grid[0][0] == player && grid[1][1] == player && grid[2][2] == player) return true; // Diagonal 

  if (grid[0][2] == player && grid[1][1] == player && grid[2][0] == player) return true; // Anti-diagonal 

  return false; 

} 

  

boolean isGridFull() { 

  for (int row = 0; row < 3; row++) { 

    for (int col = 0; col < 3; col++) { 

      if (grid[row][col] == ' ') return false; 

    } 

  } 

  return true; 

} 

  

void keyPressed() { 

  if (!gameActive) ticTacToeSetup(); 

} 

 
