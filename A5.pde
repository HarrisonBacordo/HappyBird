PImage obstacleImg;
PImage ffImage;
PImage bigGapImage;
Bird bird;
Obstacle[] obstacles;
int timeCount;
int obstacleIndex;
PImage img;
int xBackground;
int score;
float speed;
final int bGroundWidth = 1600;
boolean powerUpMode;
boolean inMenu;
boolean inRetryMenu;
boolean isNormalGame;
boolean isHardGame;
int powerUpDuration;

void setup() {
  frameRate(120);
  size(500,800);
  //load images
  img = loadImage("scrolling-background.png");
  obstacleImg = loadImage("obstacle.png");
  ffImage = loadImage("fast-forward.png");
  bigGapImage = loadImage("gap.png");
  //initialize fields
  bird = new Bird();
  bird.birdJumped();
  obstacles = new Obstacle[40];
  obstacleIndex = 0;
  xBackground = 0;
  speed = 4;
  score = 0;
  powerUpMode = false;
  powerUpDuration = 0;
  inMenu = true;
  inRetryMenu = false;
  isNormalGame = false;
  isHardGame = false;
  
}

void draw() {
  if(inMenu) {
    drawMenu();
  } else if (inRetryMenu) {
     drawRetryMenu();
  } else {
    normalGameLoop();
  }
  
}

public void normalGameLoop() {
  if(xBackground == -1600) {
    xBackground = 0;
    drawSingleBackground();
  } else if(xBackground <= -1000) {
    drawDoubleBackground();
  } else {
    drawSingleBackground();
  }
  //if we are in powerup mode, increment the duration we have been in powerup mode
  if(powerUpMode) {
    powerUpDuration++;
  }
  //update positions of and draw the bird and array
  bird.update();
  bird.drawBird();
  drawObstacleArray();
  drawScore();
  //increment time count. used to evenly space out obstacles
  timeCount++;
}

public void drawObstacleArray() {
  //add another obstacle every 60 frames
  if(timeCount % 60 == 0) {
    obstacles[obstacleIndex++] = new Obstacle();
  }
  //loop for drawing obstacles and checking if the obstacle has collided with the bird
  for(Obstacle o : obstacles) {
    if(o == null) { return; }
    o.drawObstacle();
    o.checkCollision(bird);
  }
}

public void drawScore() {
  textFont(createFont("Arial",30,true));
  text(score, width / 2, height / 7);
}

//only one background is in the frame. draw one to save memory
public void drawSingleBackground() {
  image(img, xBackground--, 0, 1600, height);
}

//the intersection of two backgrounds is in the frame. draw both
public void drawDoubleBackground() {
  image(img, xBackground--, 0, 1600, height);
  image(img, bGroundWidth + xBackground--, 0, 1600, height);
}

//called when the player collides with either the ground or an obstacle
public void stopGame() {
  delay(750); 
  inRetryMenu = true;
  isNormalGame = false;
  isHardGame = false;
}

public void drawMenu() {
  drawSingleBackground();
  fill(255,255, 255);
  textFont(createFont("Arial",45,true));
  text("HAPPY BIRD", width/5, height/2);
  textFont(createFont("Arial",15,true));
  text("Press the space bar to play normal!", width/4, height/2+20);
  text("Press the a key to play the hard version!", width/4, height/2+40);
}

public void drawRetryMenu() {
  drawSingleBackground();
  fill(255,255, 255);
  textFont(createFont("Arial",30,true));
  text("Game over, the bird crashed!", width/8, height/4);
  textFont(createFont("Arial",15,true));
  text("Press the space bar to play normal!", width/4, height/4+40);
  text("Press the a key to play the hard version!", width/4, height/4+60);
}

//detects bird jumps
public void mousePressed() {
  bird.birdJumped();
}

//used to reset the game
void keyPressed() {
  if(keyCode == ' ') {
    if(inMenu || inRetryMenu) {
      delay(1000);
      inMenu = false;
      inRetryMenu = false;
      isHardGame = false;
      isNormalGame = true;
      resetGame();
    }
  } else if (key == 'a') {
    if(inMenu || inRetryMenu) {
      delay(1000);
      inMenu = false;
      inRetryMenu = false;
      isNormalGame = false;
      isHardGame = true;
      resetGame();
    }
  }
}

void resetGame() {
  bird = new Bird();
  bird.birdJumped();
  obstacles = new Obstacle[40];
  obstacleIndex = 0;
  xBackground = 0;
  speed = 4;
  powerUpMode = false;
  powerUpDuration = 0;
  score = 0;
}