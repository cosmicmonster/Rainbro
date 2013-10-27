import javax.swing.ImageIcon;

private Rain rain;
private Rainbow rainbow;
private Filter filter;
private int  score = 0;
private int  points = 20;
private Colors colors = new Colors();

private PImage bg_menu;
private PImage bg_gameover;
private PImage bg_gameover2;
private PImage x3;
private PImage x2;
private PImage storm;
private PImage drops;
private PImage winner;
private PImage skittles;

private boolean win = false;

private color bgColor;
private Timer animationTimer;

private Unlockables unlockables = new Unlockables();
private Unicorn unibro = new Unicorn();
private Timer unibroTimer;
private Timer lightningTimer;
private Timer skittleTimer;

private Timer menuTimer;

private PFont font;

private float scoreMultiplier = 1;

private String state = "menu";

void setup () {

  size (500, 720);
  frameRate(60);
    
  ImageIcon icon = new ImageIcon(loadBytes("icon.png"));
  frame.setIconImage(icon.getImage());
  
  frame.setTitle ("Rainbro by Philipp Gullberg - BaconGameJam06");

  if (state == "menu") loadMenu();
}

void loadMenu ()
{
  menuTimer = new Timer(1000);
  menuTimer.start();
  imageMode(CENTER);
  font = loadFont("Arial-Black-32.vlw");
  bg_menu = loadImage("data/menu_bg.jpg");
}

void loadGameOver ()
{
  menuTimer = new Timer(2000);
  menuTimer.start();
}

void gameOverUpdate ()
{
  background(25, 25, 25);

  if (win) image (bg_gameover2, width/2, height/2);
  else image (bg_gameover, width/2, height/2);

  fill(194, 191, 191);
  textFont(font, 28);
  textAlign(LEFT);
  text("HAPPY RAINDROPS: " + score, 35, height - 15);
}

void menuUpdate ()
{
  background(25, 25, 25);

  image (bg_menu, width/2, height/2);

  textFont(font, 32);
  textAlign(CENTER);


  //text("CATCH RAIN DROPS[left&right keys]\n SWAP COLOR [up&down keys]", width/2, height/2);
}

void loadGame ()
{
  imageMode(CENTER);

  bg_gameover = loadImage("data/gameover_bg.jpg");
  bg_gameover2 = loadImage("data/gameover2_bg.jpg");
  storm = loadImage("data/spr_storm.png");
  drops = loadImage("data/spr_drops.png");
  x2 = loadImage("data/spr_x2.png");
  x3 = loadImage("data/spr_x3.png");
  winner = loadImage("data/spr_1.png");
  skittles = loadImage("data/spr_skittles.png");  

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
  drawBackground();
  rain.update ();
  rainbow.update ();
  checkSkittles ();
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
    Skittle skitty = rain.skittleCollide (b.get(i).pos.x, b.get(i).pos.y, b.get(i).w, b.get(i).h);
    
    if (skitty != null)
    {
      b.get(i).addColor (20);
      checkBucketHeights ();
    }
    
    if (d2 != null)
    {
      points = (int)d2.getPoints();
      
      if ( d2.getColor() == b.get(i).getColor()) 
      {  
        b.get(i).addColor (points*2);
        score += points * scoreMultiplier;
        checkBucketHeights ();
      } 
      else 
      { 
        b.get(i).removeColor (points * 2);
        if (score >= points * 2) score-=points * 2;
      }

      d2.die();
    }
  }
}

void checkGameOver ()
{
  if (rainbow.checkGameOver()) { 
    state = "gameOver"; 
    loadGameOver();
  }
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
    if (rain.isItStorming() && !lightningTimer.isDone()) 
    { 
      lightning();
    }
    else bgColor = color(25, 25, 25);

    background(bgColor);
    update ();

    fill(194, 191, 191);
    textFont(font, 14);
    textAlign(RIGHT);
    text("SCORE\n" + score, width-5, 20);
  } 
  else if (state == "menu") menuUpdate();
  else if (state == "gameOver") gameOverUpdate();
}

void lightning ()
{
  bgColor = lerpColor(bgColor, color((int)random(200,255)), .2);
  //ambientLight(51, 102, 126);

  if (lightningTimer == null || lightningTimer.isDone() ) 
  {
    lightningTimer = new Timer ((int)random(1000,3000));
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

      if (keyCode == CONTROL) 
      {
        //rainbow.getBuckets().get(0).addColor(50);
        //checkUnlock (rainbow.getBuckets().get(0).getHeight());
      }
    }
  }
  if (state == "menu" && menuTimer.isDone())
  {
    loadGame();
    state = "game";
  }
  else if (state == "gameOver" && menuTimer.isDone())
  {
    state = "menu";
    loadMenu ();
  }

  //if (key == ' ') filter.shoot();// sound.play("asdasd");
}

public void drawBackground ()
{
  fill(50, 50, 50);
  tint(50, 50, 50);

  image(winner, 60, 60);
  rect (0, 100, width/4, 5);

  if (scoreMultiplier == 3) { 
    tint(255); 
    fill(194, 191, 191);
  }
  else { 
    fill(50, 50, 50); 
    tint(50, 50, 50);
  }    

  image(x3, 60, 160);
  rect (0, 200, width/4, 5);

  if (rain.allowSkittles) { 
    tint(255); 
    fill(194, 191, 191);
  }
  else { 
    fill(50, 50, 50); 
    tint(50, 50, 50);
  }

  image(skittles, 60, 260);
  rect (0, 300, width/4, 5);

  if (scoreMultiplier == 2) { 
    tint(255); 
    fill(194, 191, 191);
  }
  else { 
    fill(50, 50, 50); 
    tint(50, 50, 50);
  }

  image(x2, 60, 360);
  rect (0, 400, width/4, 5);

  if (rain.allowStorms) { 
    tint(255); 
    fill(194, 191, 191);
  }
  else { 
    fill(50, 50, 50); 
    tint(50, 50, 50);
  }

  image(storm, 60, 460);
  rect (0, 500, width/4, 5);

  if (rain.allowEpicDrops) { 
    tint(255); 
    fill(194, 191, 191);
  }
  else { 
    fill(50, 50, 50); 
    tint(50, 50, 50);
  }

  image(drops, 60, 560);
  rect (0, 600, width/4, 5);

  tint(255);
  lightning ();
}

void checkUnlock (float topHeight)
{
  //println (topHeight);
  if (topHeight >= 120) 
  { 
    rain.allowEpicDrops = true;
  }
  else { 
    rain.allowEpicDrops = false;
  }

  if (topHeight >= 220) { 
    rain.allowStorms = true;
  }
  else { 
    rain.allowStorms = false;
  }

  if (topHeight >= 520) 
  { 
    scoreMultiplier = 3; 
    filter.speed = .5;
  }
  else if (topHeight >= 320) 
  { 
    scoreMultiplier = 2 ; 
    filter.speed = .4;
  }
  else 
  { 
    scoreMultiplier = 1; 
    filter.speed = .4;
  }

  if (topHeight >= 420) { 
    rain.allowSkittles = true; 
    filter.speed = .6;
  }
  else { 
    rain.allowSkittles = false; 
    filter.speed = .5;
  }
  if (topHeight >= 620) {  
    win = true; 
    state = "gameOver"; 
    loadGameOver();
  }
}

void checkSkittles ()
{
  if (!rain.allowSkittles) return;
  
  if (skittleTimer == null) 
  {
    skittleTimer = new Timer ((int) random(5000,10000));
    skittleTimer.start ();
  }
  
  if (skittleTimer.isDone ())
  {
    skittleTimer = new Timer ((int) random(30000,45000));
    skittleTimer.start ();
    
    Bucket b = rainbow.getBuckets().get(getLowestBucket());
    
    rain.spawnSkittle(b.pos.x+(b.w/2), 0, b.getColor());
  }

}

int getLowestBucket ()
{
  ArrayList<Bucket> b = rainbow.getBuckets ();
  float minHeight = height;
  int bucky = 0;

  for (int i = 0; i < b.size(); i++)
  {
    if (b.get(i).getHeight() < minHeight && b.get(i).getHeight() > 0) 
    {
      minHeight = b.get(i).getHeight();
      bucky = i;
    }
  }

  return bucky;
}
