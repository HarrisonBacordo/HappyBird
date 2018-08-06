public class FastForward implements PowerUp {
  private float x;
  private float y;
  private float w = 25;
  private float h = 25;
  public boolean doDraw = true;
  private int powerUpLength = 300;
  
  public FastForward(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  //draws the powerup
  public void drawPowerUp(float x) {
    if(doDraw) {
      this.x = x;
      image(ffImage, x, y, 25, 25);
      checkCollision();
    }
  }
  
  //checks if the bird is colliding with this powerup
  public void checkCollision() {
    if(bird.x + 30 >= this.x && bird.x <= this.x + w && bird.y + 35 >= this.w){
      if(!powerUpMode) {
        doDraw = false;
        powerUpMode = true;
      }
    }
  }
  
  //returns the duration of time this powerup is meant to hold its effect
  public int getPowerUpLength() {
    return powerUpLength;
  }
  
  //returns the doDraw variable. This is called to check if the powerup has been collected and should
  //therefore initiate powerup mode
  public boolean getDoDraw() {
    return doDraw;
  }
}