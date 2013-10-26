public class Rain {
  
  private ArrayList<Drop> drops;
  Timer timer;
  public int totalDrops = 0;
  
  Rain ()
  {
    drops = new ArrayList<Drop>();
    timer = new Timer((int)random(0,500));
    timer.start();
  }
  
  public void update ()
  {
    updateDrops ();
    
    if (timer.isDone ()) 
    {
      spawnDrop ();
      timer = new Timer((int)random(2000,3000));
      timer.start();      
    }
  }
  
  private void spawnDrop ()
  {
    drops.add(new Drop());
    totalDrops++;
    //println("What a glorious da.... wait shit it's raining :(");
  }
  
  private void updateDrops ()
  {
    for (int i = 0; i < drops.size(); i++)
    {
      if (drops.get(i).isDead()) drops.remove(i);
      else drops.get(i).update();
    }
  }
  
  public Drop collide (float x, float y, float w, float h)
  {
    for (int i = 0; i < drops.size(); i++)
    {
      Drop d = drops.get(i);
      
      if (d.collide(x,y,w,h)) return d;
    }
    
    return null;
  }
}

public class Drop {
  
  public PVector pos;
  private PVector dir = new PVector(0, 1);
  public float w,h;
  private boolean kill = false;
  private color c = color(255,255,255);
  private boolean isFiltered = false;
  
  Drop ()
  {
    this.w = 10;
    this.h = 10;
    pos = new PVector(0,0);
    pos.x = getNewPos();
    dir.normalize();
  }
  
  public void update () 
  {
    if (pos.y > height) { kill = true; return; }
    
    move ();
    drawDrop();
  }
  
  private void move ()
  {
    if (!isFiltered) dir.mult(1.01);
    else { if (dir.mag() > 1) dir.mult(.7); }
    pos.add(dir);
  }
  
  private void drawDrop ()
  {
    fill(c);
    
    if (!isFiltered) rect (pos.x,pos.y, w, h);
    else { 
      this.w = 5;
      ellipse (pos.x+w/2, pos.y+w/2, w, w);
    }
  }
  
  private float getNewPos ()
  {
    float t = width/14 + (2*(int)random(0,7))*width/14 -w/2;
    println(t);
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
