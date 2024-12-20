class Pong implements Game, UIScreen{
  int rad = 30;        // Width of the circle
  float circleX, circleY;    // Starting position of shape    

  float xspeed = 2.8;  // Speed of the shape
  float yspeed = 5.7;  // Speed of the shape

  int xdirection = 1;  // Left or Right
  int ydirection = 1;  // Top to Bottom

  float rectHeight = 20;
  float rectWidth = 80;
  
  int score = 0; // Game variables
  
  Pong(){
    generate();
  }
  
  public void generate(){
    //add circle stuff to make the circle move
    noStroke();
    /*frameRate(30);
    ellipseMode(RADIUS);*/
    // Set the starting position of the shape
    circleX = width/2;
    circleY = height/2;
  }
  
  public void update(){}
  
  public void check(){}
  
  public void disp(){
    background(255);
    fill(0,235,0);
    //rect(mouseX - 25, 0, 100, 25);
  

    //create the rectangle first, this will be the platform
    float rectY = height - rectHeight - 50; // Position the rectangle near the bottom of the canvas
    float rectX = mouseX - rectWidth / 2;
  
    rect(mouseX - rectWidth / 2, rectY, rectWidth, rectHeight);
  
    //now create a ball 
    //has to be within the frame
  
    // Update the position of the shape when it hits the frame
    circleX = circleX + ( xspeed * xdirection ); 
    circleY = circleY + ( yspeed * ydirection );
  
    //To keep it in frame, check if the position of the circle goes outside of the software,
    //if it does, make the circle go the other way
    if (circleX > width-rad || circleX < rad) {
      xdirection *= -1;
    }
    if (circleY > height-rad || circleY < rad) {
      ydirection *= -1;
    }
    ellipse(circleX, circleY, rad, rad);
    // Ball-platform collision detection
    if (circleY + rad >= rectY && circleX >= rectX && circleX <= rectX + rectWidth) {
      yspeed *= -1; // Reverse ball direction
      score++; // Increase score
      xspeed *= 1.1; // Increase speed
      yspeed *= 1.1; // Increase speed
    }
  
  //println(circleY+","+rad+","+(circleY +rad)+","+ height);
  println(circleY + rad > height);
    //if the ball passes the platform, it ends!! that is it
    if (circleY + rad > height) {
      fill(0);
      textSize(32);
      textAlign(CENTER, CENTER);
      text("Game Over! Score: " + score, width / 2, height / 2);
      
      int t=millis();
      while(millis()-t<500){
      }
      G=new Menu();
    }
  
    // Display score
    fill(0);
    textSize(16);
    textAlign(LEFT, CENTER);
    text("Score: " + score, 10, 20);
  }
}
