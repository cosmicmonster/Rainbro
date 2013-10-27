public class Rain {

  private ArrayList<Drop> drops;
  private ArrayList<Splash> splashes;
  private Timer timer;
  public int totalDrops = 0;
  public boolean allowEpicDrops;
  public boolean allowStorms;
  private Timer stormTimer;
  private Timer stormInterval;
  
  private int timerInterval = 2000;

  Rain ()
  {
    drops = new ArrayList<Drop>();
    splashes = new ArrayList<Splash>();
    timer = new Timer((int)random(0, 500));
    timer.start();
    
    stormInterval = new Timer((int)random(3000,6000));
    stormInterval.start();
  }

  public void update ()
  {
    updateDrops ();
    updateSplash ();
    
    if (allowStorms && stormInterval != null && stormInterval.isDone())
    {
      stormTimer = new Timer (10000);
      stormTimer.start();
      timerInterval = 1150;
      stormInterval = null;
      println("storm started @ " + millis());
    }

    if (timer.isDone ()) 
    {
      spawnDrop ();
           
      timer = new Timer((int)random(timerInterval, timerInterval*1.5));
      timer.start();
    }
    
    if (stormTimer != null && stormTimer.isDone ())
    {
      stormTimer = null;
      timerInterval = 2000;
      stormInterval = new Timer((int)random(30000,60000));
      stormInterval.start();
      println("storm finished @ " + millis());
    }
  }
  
  public boolean isItStorming ()
  {
    if (stormTimer == null) return false;
    
    return true;
  }

  private void spawnDrop ()
  {
    drops.add(new Drop(allowEpicDrops));
    
    totalDrops++;
  }

  private void updateDrops ()
  {
    for (int i = 0; i < drops.size(); i++)
    {
      if (drops.get(i).isDead()) {
        splashes.add(new Splash(drops.get(i).pos, 20, drops.get(i).getColor()));
        drops.remove(i);
      }
      else drops.get(i).update();
    }
  }

  private void updateSplash ()
  {
    for (int i = 0; i < splashes.size(); i++)
    {
      if (splashes.get(i).kill) splashes.remove(i);
      else splashes.get(i).update();
    }
  }

  public Drop collide (float x, float y, float w, float h)
  {
    for (int i = 0; i < drops.size(); i++)
    {
      Drop d = drops.get(i);

      if (d.collide(x, y, w, h)) return d;
    }

    return null;
  }
}

public class Drop {

  public PVector pos;
  private PVector dir = new PVector(0, 1);
  public float w, h;
  private boolean kill = false;
  private color c = color(255, 255, 255);
  private boolean isFiltered = false;
  private PImage rainDrop;
  private float[] sizes = new float[3];

  Drop (boolean allowEpicDrops)
  {
    if (allowEpicDrops) this.w = randomSize();
    else this.w = 10;
    
    this.h = w*1.43;
    pos = new PVector(0, 0);
    pos.x = getNewPos();
    dir.normalize();
    //rainDrop = loadImage("img/spr_drop.png");
    //rainDrop.resize((int)w, (int)h);
  }

  private float randomSize ()
  {
    sizes[0] = 10;
    sizes[1] = 15;
    sizes[2] = 20;

    return sizes[(int)random(0, 3)];
  }
  
  public float getPoints ()
  {
    return this.w;
  }

  public void update () 
  {
    if (kill) return;

    if (pos.y > height) 
    { 
      kill = true;

      return;
    }

    move ();
    drawDrop();
  }

  private void move ()
  {
    if (!isFiltered) dir.mult(1.01);
    else { 
      if (dir.mag() > 1) dir.mult(.7);
    }
    pos.add(dir);
  }

  private void drawDrop ()
  {
    fill(c);

    if (!isFiltered) ellipse (pos.x,pos.y, w, w);//image (rainDrop, pos.x, pos.y); 
    else { 
      this.w = 5;
      ellipse (pos.x+w/2, pos.y+w/2, w, w);
    }
  }

  private float getNewPos ()
  {
    float t = width/14 + (2*(int)random(0, 7))*width/14;
    return t;
  }

  public boolean isDead ()
  {
    return kill;
  }

  public void die ()
  {
    kill = true;
  }

  public boolean collide (float x, float y, float w, float h)
  {
    if (pos.x > x && pos.y > y && pos.x < x+w && pos.y < y+h) 
    {
      isFiltered = true;
      return true;
    }

    return false;
  }

  public void changeColor (color c)
  {
    this.c = c;
  }

  public color getColor ()
  {
    return c;
  }
}

