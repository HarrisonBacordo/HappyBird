class Obstacle {
  public static final int yTop = -10;  //to account for img
  public float w = 75;
  private float wForCollision = (w / 4) * 3;
  boolean isPowerUpTriggered = false;
  boolean scoreIncremented = false;
  PowerUp powerUp;  //holds the powerup betwee nthe obstacle, if there is one
  float x = 1000;
  float hTop;  //height of top obstacle
  float hBottom;  //height of bottom obstacle
  float bottomOfTop;  //yPos of the bottom end of the top obstacle
  float topOfBottom;  //yPos of the top end of the bottom obstacle
  float gapSize = 150;  //how many pixels between top and bottom log
  
  public Obstacle() {
    hTop = random(100, 600);
    bottomOfTop = yTop + hTop;
    topOfBottom = bottomOfTop + gapSize;
    hBottom = height - topOfBottom + 10;
    tryCreatePowerUp(int(random(6)));
    if(isHardGame) {
      gapSize = 125;
      w = 100;
    }
  }
  
  //draws the obstacle along with the powerup
  public void drawObstacle() {
    image(obstacleImg, x, yTop, w, hTop);
    image(obstacleImg, x, topOfBottom, w, hBottom);
    if(powerUp != null) {
      powerUp.drawPowerUp(x);
      if(!powerUp.getDoDraw()) {
        triggerPowerUp();
        checkPowerUpTime();
      }
    }
    x -= speed;
  }
  
  //checks if the bird is colliding with either the top or bottom obstacle
  //also checks for collision with ground
  public void checkCollision(Bird bird) {
    if (bird.y + 30 >= height) {
      println("HIT BOTTOM");
      stopGame();
    }
    checkTopObstacle();
    checkBottomObstacle();
    checkIncrementScore();
  }
  
  //checks top obstacle collision
  public void checkTopObstacle() {
    if(bird.x + 30 >= this.x && bird.x <= this.x + wForCollision && bird.y + 25 < this.bottomOfTop){
      stopGame();
    }
  }
  
  //checks bottom obstacle collision
  public void checkBottomObstacle() {
      if(bird.x + 30 >= this.x && bird.x <= this.x + wForCollision && bird.y + 25 >= this.topOfBottom){
        stopGame();
      }
  }
  
  public void checkIncrementScore() {
    if (bird.x >= this.x + (w / 2) - 10 && bird.x <= this.x + (w / 2) + 10 && !scoreIncremented) {
      score++;
      scoreIncremented = true;
    }
  }
  
  //takes in random int between 0 and 5, creates the powerUp if the int is 0
  public void tryCreatePowerUp(int chance) {
    if (chance == 0) {
      createPowerUp(int(random(1)));
    }
  }
  
  //takes in random int between 0 and 1, creating the speicifed powerup for each number
  public void createPowerUp(int chance) {
    switch(chance) {
      case 0:
        powerUp = new FastForward(this.x + (w / 2), (bottomOfTop + topOfBottom) / 2);
        powerUp.drawPowerUp(x);
        break;
    }
  }
  
  //triggers the powerup's effect
  public void triggerPowerUp() {
    if(!isPowerUpTriggered) {
      if(powerUp instanceof FastForward) {
        speed = 5.25;
      }
    }
    isPowerUpTriggered= true;
  }
  
  //checks the duration of time we have been in powermode against max duration of time
  //the powerup lasts. changes itself accordingly
  public void checkPowerUpTime() {
    if(powerUpDuration >= powerUp.getPowerUpLength()) {
      powerUpMode = false;
      powerUpDuration = 0;
      speed = 4;
    }
  }
}