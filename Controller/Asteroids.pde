class Asteroids implements Game {
  PVector shipPos, shipVel;
  float shipAngle;
  boolean thrusting, turningLeft, turningRight;
  ArrayList<Asteroid> asteroids;
  ArrayList<Bullet> bullets;
  int health, score;
  boolean gameOver;

  Asteroids() {
    generate();
  }

  public void generate() {
    shipPos = new PVector(width / 2, height / 2);
    shipVel = new PVector(0, 0);
    shipAngle = 0;
    thrusting = turningLeft = turningRight = false;
    health = 3;
    score = 0;
    gameOver = false;
    asteroids = new ArrayList<Asteroid>();
    bullets = new ArrayList<Bullet>();

    for (int i = 0; i < 5; i++) {
      asteroids.add(new Asteroid());
    }
  }

  public void update() {
    if (gameOver) {
      if (keyPressed && key == ENTER) {
        generate(); // Restart the game
      }
      return;
    }

    //  input
    if (keyPressed) {
      if (keyCode == UP) thrusting = true;
      if (keyCode == LEFT) turningLeft = true;
      if (keyCode == RIGHT) turningRight = true;
      if (key == ' ') {
        bullets.add(new Bullet(shipPos.copy(), radians(shipAngle)));
      }
    } else {
      thrusting = turningLeft = turningRight = false;
    }

    if (turningLeft) shipAngle -= 4;
    if (turningRight) shipAngle += 4;

    if (thrusting) {
      PVector thrust = PVector.fromAngle(radians(shipAngle));
      thrust.mult(0.1);
      shipVel.add(thrust);
    }

    shipPos.add(shipVel);
    shipVel.mult(0.99);

    if (shipPos.x > width) shipPos.x = 0;
    if (shipPos.x < 0) shipPos.x = width;
    if (shipPos.y > height) shipPos.y = 0;
    if (shipPos.y < 0) shipPos.y = height;

    for (int i = bullets.size() - 1; i >= 0; i--) {
      Bullet b = bullets.get(i);
      b.update();
      if (b.offScreen()) bullets.remove(i);
    }

    for (int i = asteroids.size() - 1; i >= 0; i--) {
      Asteroid a = asteroids.get(i);
      a.update();

      for (int j = bullets.size() - 1; j >= 0; j--) {
        Bullet b = bullets.get(j);
        if (a.contains(b.pos)) {
          bullets.remove(j);
          score += 10;
          if (a.r > 20) {
            asteroids.add(new Asteroid(a.pos, a.r / 2));
            asteroids.add(new Asteroid(a.pos, a.r / 2));
          }
          asteroids.remove(i);
          break;
        }
      }

      if (a.contains(shipPos)) {
        health--;
        asteroids.remove(i);
        if (health <= 0) {
          gameOver = true;
        }
      }
    }

    if (asteroids.size() < 3) {
      for (int i = 0; i < 3; i++) {
        asteroids.add(new Asteroid());
      }
    }
  }

  public void disp() {
    background(0, 0, 0);

    pushMatrix();
    translate(shipPos.x, shipPos.y);
    rotate(radians(shipAngle));
    fill(0, 255, 250);
    stroke(255);
    triangle(15, 0, -15, -10, -15, 10);
    popMatrix();

    
    for (Bullet b : bullets) {
      b.display();
    }

    for (Asteroid a : asteroids) {
      a.display();
    }

    // health and score
    fill(255);
    textSize(12);
    text("Health: " + health, 20, 30);
    text("Score: " + score, 20, 50);

    
    if (gameOver) {
      textSize(32);
      fill(255, 50, 50);
      textAlign(CENTER);
      text("GAME OVER", width / 2, height / 2);
      text("Press ENTER to Restart", width / 2, height / 2 + 40);
    }
  }

  public void check() {
  }
}

class Asteroid {
  PVector pos, vel;
  float r; // Base radius of the asteroid
  int sides; // Number of sides for the polygon
  float[] offsets; // Array to store offset distances for each vertex

  Asteroid() {
    pos = new PVector(random(width), random(height));
    vel = PVector.random2D();
    vel.mult(random(1, 3));
    r = random(20, 60);
    sides = floor(random(5, 9)); // Random number of sides (e.g., 5 to 8)
    offsets = new float[sides];
    for (int i = 0; i < sides; i++) {
      offsets[i] = r + random(-r * 0.4, r * 0.4); // Randomize offsets
    }
  }

  Asteroid(PVector startPos, float radius) {
    pos = startPos.copy();
    vel = PVector.random2D();
    vel.mult(random(1, 3));
    r = radius;
    sides = floor(random(5, 9)); // Random number of sides
    offsets = new float[sides];
    for (int i = 0; i < sides; i++) {
      offsets[i] = r + random(-r * 0.4, r * 0.4); // Randomize offsets
    }
  }

  void update() {
    pos.add(vel);
    if (pos.x > width) pos.x = 0;
    if (pos.x < 0) pos.x = width;
    if (pos.y > height) pos.y = 0;
    if (pos.y < 0) pos.y = height;
  }

  void display() {
    fill(0, 255, 20);
    stroke(255);
    strokeWeight(1);
    beginShape();
    for (int i = 0; i < sides; i++) {
      float angle = map(i, 0, sides, 0, TWO_PI);
      float x = pos.x + cos(angle) * offsets[i];
      float y = pos.y + sin(angle) * offsets[i];
      vertex(x, y);
    }
    endShape(CLOSE);
  }

  boolean contains(PVector point) {
    return dist(pos.x, pos.y, point.x, point.y) < r;
  }
}


class Bullet {
  PVector pos, vel;

  Bullet(PVector startPos, float angle) {
    pos = startPos.copy();
    vel = PVector.fromAngle(angle);
    vel.mult(6);
  }

  void update() {
    pos.add(vel);
  }

  void display() {
    fill(255, 255, 100);
    noStroke();
    ellipse(pos.x, pos.y, 4, 4);
  }

  boolean offScreen() {
    return pos.x > width || pos.x < 0 || pos.y > height || pos.y < 0;
  }
}
