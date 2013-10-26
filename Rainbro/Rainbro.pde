private Rain rain;
private Rainbow rainbow;
private Filter filter;
private int  score = 0;

private Cloud c1;
private Cloud c2;
private Cloud c3;


void setup () {

  size (500, 720);
  frameRate(30);
  load ();
}

void load ()
{
  imageMode(CENTER);
  c1 = new Cloud (width/1.25, 20);
  c2 = new Cloud (width/2.0, 15);
  c3 = new Cloud (width/5, 30);
  
  rain = new Rain();
  rainbow = new Rainbow();
  filter = new Filter(0, height-40, width/7.0, 20);
}

void update ()
{
  checkGameOver ();
  rain.update ();
  rainbow.update ();
  c1.update();
  c2.update();
  c3.update();
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
        b.get(i).addColor (8.0);
        checkBucketHeights ();
      } else b.get(i).removeColor (16.0);
      
      d2.die();
    }
  }
}

void checkGameOver ()
{
   if (rainbow.checkGameOver()) { println("GAME OVER! Score: " + score); load();} 
}

void checkBucketHeights ()
{
  ArrayList<Bucket> b = rainbow.getBuckets ();
  float topHeight = 0;
  
  score = 0;
  for (int i = 0; i < b.size(); i++)
  {
    score += b.get(i).getHeight();
    if (b.get(i).getHeight() > topHeight) topHeight = b.get(i).getHeight();
  }

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
