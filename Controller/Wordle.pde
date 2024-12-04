class Wordle implements Game {
  
  //create a secret word for now 
  String secretWord = "apple";
  String userGuess = "";
  String feedback = "";
  int remainingAttempts = 6;
  String[] previousGuesses = new String[6];
  
  void generate() { //initialize
    secretWord = "apple";  // Set or randomize the secret word here
    userGuess = "";
    feedback = "";
    remainingAttempts = 6;
    for (int i = 0; i < previousGuesses.length; i++) {
      previousGuesses[i] = "";  // Clear previous guesses
    }
  }
  
  
  void update() {
    // No general update logic needed here; handled in keyPressed
  }

  void updateKey(char key) {
    if (key >= 'a' && key <= 'z' && userGuess.length < 5) {
      userGuess += key;  // Add the letter to the guess if it's valid
    }
    if (userGuess.length == 5) {
      check();  // Check the guess once it is fully entered
    }
  }

  void updateMouse(int x, int y) {
    // For Wordle, mouse input may not be needed, but you can include it for future games
  }

  void check() {
    // Check if the guess is correct and provide feedback
    if (userGuess.equals(secretWord)) {
      winMessage();
    } else if (remainingAttempts <= 0) {
      loseMessage();
    } else {
      feedback = getFeedback(userGuess, secretWord);  // Provide feedback on the guess
      storePreviousGuess(userGuess);
      remainingAttempts--;
      userGuess = "";  // Reset user guess for next input
    }
  }

  void disp() {
    background(255);
    textSize(20);
    textAlign(CENTER, CENTER);
    text("Guess the 5-letter word", width / 2, 50);
    text("Attempts left: " + remainingAttempts, width / 2, 80);

    // Display previous guesses
    for (int i = 0; i < previousGuesses.length; i++) {
      text(previousGuesses[i], width / 2, 150 + (i * 30));
    }

    // Display feedback after each guess
    text("Feedback: " + feedback, width / 2, 300);

    // Display the current guess
    text("Current guess: " + userGuess, width / 2, 350);
  }

  String getFeedback(String guess, String secretWord) {
    String feedback = "";
    for (int i = 0; i < secretWord.length(); i++) {
      char guessLetter = guess.charAt(i);
      char secretLetter = secretWord.charAt(i);

      if (guessLetter == secretLetter) {
        feedback += guess.charAt(i); // Correct position
      } else if (secretWord.contains(String.valueOf(guessLetter))) {
        feedback += "X"; // Correct letter, wrong position
      } else {
        feedback += "_"; // Incorrect letter
      }
    }
    return feedback;
  }

  void storePreviousGuess(String guess) {
    for (int i = previousGuesses.length - 1; i > 0; i--) {
      previousGuesses[i] = previousGuesses[i - 1];  // Shift guesses down
    }
    previousGuesses[0] = guess;  // Add the most recent guess at the top
  }

  void winMessage() {
    textSize(30);
    text("You guessed the word! The word was " + secretWord, width / 2, 450);
  }

  void loseMessage() {
    textSize(30);
    text("Game Over! The word was " + secretWord, width / 2, 450);
  }
}
  
