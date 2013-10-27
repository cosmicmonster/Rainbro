import ddf.minim.*;

private Rain rain;
private Rainbow rainbow;
private Filter filter;
private int  score = 0;
private int  points = 20;
private Colors colors = new Colors();

private PImage bg;
private PImage hills;
private PImage[] sun = new PImage[2];
private int sunLoop = 0;

private color bgColor;
private Timer animationTimer;

private Unlockables unlockables = new Unlockables();
private Unicorn unibro = new Unicorn();
private Timer unibroTimer;
private Timer lightningTimer;

private PFont font;

private float scoreMultiplier = 1;

private String state = "menu";

void setup () {

  size (500, 720);
  frameRate(60);
  
  if (state == "menu") loadMenu();
}

void loadMenu ()
{
  font = loadFont("Ebrima-Bold-32.vlw");
  println("press any key to continue");
}

void loadGameOver ()
{

}

void gameOverUpdate ()
{
  background(25,25,25);
  
  textFont(font, 32);
  textAlign(CENTER);
  text("GAME OVER BRO!", width/2, height/2);
  fill (colors.getColor((int)random(0,7)));
  text("SCORE: " + score, width/2, height/2+ 40);
}

void menuUpdate ()
{
  background(25,25,25);
  
  textFont(font, 32);
  textAlign(CENTER);
  //text("CATCH RAIN DROPS[left&right keys]\n SWAP COLOR [up&down keys]", width/2, height/2);
}

void loadGame ()
{
  imageMode(CENTER);
  
  bg = loadImage("img/bg.jpg");
  hills = loadImage("img/spr_bg.png");
  sun[0] = loadImage("img/spr_sun01.png");
  sun[1] = loadImage("img/spr_sun02.png");
  
  rain = new Rain();
  rainbow = new Rainbow();
  filter = new Filter(0, height-40, width/7.0, 20);
  
  animationTimer = new Timer(200);
  animationTimer.start();
  
  score = 0;
}

void update ()
{
  checkGameOver ();
  
  rain.update ();
  rainbow.update ();
  drawBackground();
  updateUnlockables();
  filter.update ();
  checkCollisions ();
}


void checkCollisions ()
{
  Drop d = rain.collide(filter.pos.x, filter.pos.y, filter.w, filter.h);
  if (d != null)
  {
    d.changeColor (filter.getColor());
  }

  ArrayList<Bucket> b = rainbow.getBuckets();

  for (int i = 0; i < b.size(); i++)
  {
    Drop d2 = rain.collide (b.get(i).pos.x, b.get(i).pos.y, b.get(i).w, b.get(i).h);

    if (d2 != null)
    {
      if ( d2.getColor() == b.get(i).getColor()) 
      {
        points = (int)d2.getPoints()*4;
        b.get(i).addColor (points);
        println(scoreMultiplier);
        score += points * scoreMultiplier;
        checkBucketHeights ();
      } else 
      { 
        b.get(i).removeColor (points * 1.5);
        if (score >= points * 1.5) score-=points * 1.5;
      }
      
      d2.die();
    }
  }
}

void checkGameOver ()
{
   if (rainbow.checkGameOver()) { state = "gameOver"; loadGameOver();}//load();} 
}

void checkBucketHeights ()
{
  ArrayList<Bucket> b = rainbow.getBuckets ();
  float topHeight = 0;
  
  for (int i = 0; i < b.size(); i++)
  {
    if (b.get(i).getHeight() > topHeight) topHeight = b.get(i).getHeight();
  }
  
  checkUnlock (topHeight);
  filter.updatePosition (topHeight);
}

void draw () {
  
  if (state == "game")
  {
  if (rain.isItStorming() && !lightningTimer.isDone()) { flicker(); }
  else bgColor = color(25,25,25);
  
  background(bgColor);
  update ();
  
  fill(255);
  textFont(font,14);
  text("SCORE: " + score, width-100.0, 20);
  } else if (state == "menu") menuUpdate();
  else if (state == "gameOver") gameOverUpdate();
}

void flicker ()
{
  //bgColor = lerpColor(bgColor, (int)random(255), .1);
  //ambientLight(51, 102, 126);
  
  if(lightningTimer == null)     
  {
    lightningTimer = new Timer (2000);
    lightningTimer.start();
  }
  
  if (lightningTimer.isDone()) 
  {
    lightningTimer = new Timer (2000);
    lightningTimer.start();
  }
}

void keyPressed ()
{
  if (state == "game")
  {
    if (key == CODED) 
    {
      if (keyCode == LEFT) filter.move(-1);
      else if (keyCode == RIGHT) filter.move(1);
  
      if (keyCode == UP) filter.changeColor(1);
      if (keyCode == DOWN) filter.changeColor(-1);
    }
  }
  if (state == "menu")
  {
    loadGame();
    state = "game";
  }
  else if (state == "gameOver")
  {
    state = "menu";
    loadMenu ();
  }
  
  //if (key == ' ') filter.shoot();// sound.play("asdasd");
}

public void drawBackground ()
{
    fill(255, 127);
    rect (0, 100, width/4, 5);
    rect (0, 200, width/4, 5);
    rect (0, 300, width/4, 5);
    rect (0, 400, width/4, 5);
    rect (0, 500, width/4, 5);
    rect (0, 600, width/4, 5);
    
    flicker ();
}

void checkUnlock (float topHeight)
{
    if (topHeight >= 120) { rain.allowEpicDrops = true; }
    else { rain.allowEpicDrops = false; }
    
    if (topHeight >= 220) { rain.allowStorms = true; }
    else { rain.allowStorms = false; }
    
    if (topHeight >= 420) { scoreMultiplier = 3; }
    else if (topHeight >= 320) scoreMultiplier = 2;
    else scoreMultiplier = 1;  
    
    if (topHeight >= 520) println("5th level");
    if (topHeight >= 620) println("6th level");
}

void updateUnlockables ()
{
  //updateUnibro ();
}

