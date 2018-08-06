class Bird {
  final int x = width / 3;
  private int vy = 0;
  public float y = height / 2;
  private final float gravity = 15;
  private PImage img;
  
  public Bird() {
    img = loadImage("flappy_bird.png");
  }
  
  //draws bird
  public void drawBird() {
    if(isNormalGame) {
      image(img, x, y, 50, 50);
    } else {
      image(img, x, y, 75, 75);
    }
    
  }
  
  //changes the bird vertical velocity to go upward
  public void birdJumped() {
    vy = -13;
  }
  
  //updates bird's x y position
  public void update() {
    y += vy;
    if(vy < gravity) {
      vy += 1;
    }
    
  }
}