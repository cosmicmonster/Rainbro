import ddf.minim.*;

private Rain rain;
private Rainbow rainbow;
private Filter filter;
private int  score = 0;
private int  points = 20;

private PImage bg;
private PImage hills;
private PImage[] sun = new PImage[2];
private int sunLoop = 0;

private Timer animationTimer;

private Cloud c1;
private Cloud c2;
private Cloud c3;

private Unlockables unlockables = new Unlockables();
private Unicorn unibro = new Unicorn();
private Timer unibroTimer;

void setup () {

  size (500, 720);
  frameRate(60);
  load ();
}

void load ()
{
  imageMode(CENTER);
  c1 = new Cloud (width/1.25, 20);
  c2 = new Cloud (width/2.0, 15);
  c3 = new Cloud (width/5, 30);
  
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
  drawBackground();
  rain.update ();
  rainbow.update ();
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
        b.get(i).addColor (points);
        score += points;
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
   if (rainbow.checkGameOver()) { println("GAME OVER! Score: " + score); }//load();} 
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
  background(25, 25, 25);
  update ();
}

void keyPressed ()
{
  if (key == CODED) 
  {
    if (keyCode == LEFT) filter.move(-1);
    else if (keyCode == RIGHT) filter.move(1);

    if (keyCode == UP) filter.changeColor(1);
    if (keyCode == DOWN) filter.changeColor(-1);
  }
  
  if (key == ' ') filter.shoot();// sound.play("asdasd");
}

public void drawBackground ()
{
    for (int i = 0; i < height; i+=20)
    {
      //image(bg, width/2, i); // = loadImage("img/spr_bg2.png");
    }
    
    //image(bg, width/2, height/2);
    
    fill(255, 127);
    rect (0, 100, width/4, 5);
    rect (0, 200, width/4, 5);
    rect (0, 300, width/4, 5);
    rect (0, 400, width/4, 5);
    rect (0, 500, width/4, 5);
    rect (0, 600, width/4, 5);
    
    if (animationTimer.isDone())
    {
      if (sunLoop == 1) sunLoop = 0;
      else sunLoop = 1;
      
      animationTimer = new Timer(200);
      animationTimer.start();
    } 
    
    //image(sun[sunLoop], width/2.0+25, 470);
    

    //image(hills, width/2.0, 600.0); //= loadImage("img/spr_bg.png");    
}

void checkUnlock (float topHeight)
{
    if (topHeight >= 120) unlockables.allowDrops = true;
    if (topHeight >= 220) unlockables.allowMult2 = true;
    if (topHeight >= 320) println("3rd level");
    if (topHeight >= 420) println("4th level");
    if (topHeight >= 520) println("5th level");
    if (topHeight >= 620) println("6th level");
}

void updateUnlockables ()
{
  updateUnibro ();
}



public class Cloud {
  PVector pos;
  PImage cloud;
  
  Cloud (float x, float y) {
    this.pos = new PVector(0,0);
    cloud = loadImage ("img/spr_clouds.png");
    
    this.pos.x = x;
    this.pos.y = y;
  }
  
  public void update ()
  {
    image (cloud, pos.x, pos.y);
  }
}
