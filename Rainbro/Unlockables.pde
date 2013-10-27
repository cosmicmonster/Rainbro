public class Unlockables {
  
  public boolean allowUnicorn = false;
  public boolean allowMult2 = false;
  public boolean allowMult3 = false;
  public boolean allowLazor = false;
  public boolean allowSkittles = false;
  public boolean allowDrops = false;
  
  Unlockables ()
  {
  }
}



public class Unicorn
{
  private PVector pos;
  private PVector dir;
  private boolean kill;

  private float w, h;

  private float theta = 0.0;
  private float amplitude = 25.0;
  private float randomY;
  private float pooX;

  private boolean hasPooped = false;

  private UnicornPoop poop;

  Unicorn ()
  {
    this.w = 40;
    this.h = 20;

    dir = new PVector(0, 0);
    pos = new PVector(1000, 1000);

    dir.x = random(2) < 1 ? 1 : -1;
    dir.mult(3);

    println(dir.x);
    pos.x = dir.x > 0 ? -w : 500+w;
    randomY = random(h/2+amplitude, 720-h/2-amplitude);

    pooX = random(500/14, 500-500/14);
  }

  public void update ()
  {
    if (poop != null) poop.update();

    fly ();
    checkOutOfBounds ();
    drawUnicorn ();

    if (!hasPooped && abs(pos.x - pooX) < 2) poo();
  }

  private void checkOutOfBounds ()
  {
    if (dir.x > 0 && pos.x+w > 500) kill = true;
    else if (dir.x < 0 && pos.x+w < -w) kill = true;
  }

  private void drawUnicorn ()
  {
    //image (imgUnicorn, pos.x, pos.y);
    fill (255, 0, 255);
    rect (pos.x, pos.y, w, h);
  }

  private void fly ()
  {
    theta += 0.1;

    pos.add(dir);

    pos.y = (sin(theta) * amplitude) + randomY;
  }

  private void poo ()
  {
    println("poop naauu!");
    hasPooped = true;

    poop = new UnicornPoop (pos.x, pos.y);
  }
}

public class UnicornPoop
{
  public PVector pos;
  private PVector gravity = new PVector(0, 1);

  Colors colors = new Colors ();

  UnicornPoop (float x, float y)
  {
    this.pos = new PVector(x,y);
  }

  public void update ()
  {
    gravity.mult(1.02);
    this.pos.add(gravity);
    drawPoop();
  }

  private void drawPoop ()
  {
    fill(colors.getColor((int)random(0, 7)));
    ellipse (pos.x, pos.y, 12, 6);

  }
  
  public boolean collide (float x, float y, float w, float h)
  {
    if (pos.x > x && pos.y > y && pos.x < x+w && pos.y < y+h) return true;

    return false;
  }  
  
}

void spawnUnibro ()
{
    unibro = new Unicorn();
    
    unibroTimer = new Timer((int)random(1000,4000));
    unibroTimer.start();
}

void updateUnibro ()
{
  if (unlockables.allowUnicorn) 
  {
    if (unibroTimer == null) 
    {
      unibroTimer = new Timer((int)random(1000,4000));
      unibroTimer.start();      
    }
    
    if (unibroTimer.isDone ())
    {
      spawnUnibro ();
    }
    
    if( unibro != null) unibro.update();
  }  
}
