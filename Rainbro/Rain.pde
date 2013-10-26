public class Rain {
  
  private ArrayList<Drop> drops;
  Timer timer;
  
  Rain ()
  {
    drops = new ArrayList<Drop>();
    timer = new Timer((int)random(1000,1100));
    timer.start();
  }
  
  public void update ()
  {
    updateDrops ();
    
    if (timer.isDone ()) 
    {
      spawnDrop ();
      timer = new Timer((int)random(1000,1100));
      timer.start();      
    }
  }
  
  private void spawnDrop ()
  {
    drops.add(new Drop());
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
  
  private PVector pos;
  private PVector dir = new PVector(0, 1);
  private float w,h;
  private boolean kill = false;
  private color c = color(255,255,255);
  
  Drop ()
  {
    this.w = 10;
    this.h = 10;
    pos = new PVector(0,-h);
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
    dir.mult(1.01);
    pos.add(dir);
  }
  
  private void drawDrop ()
  {
    fill(c);
    rect (pos.x,pos.y, w, h);
  }
  
  private float getNewPos ()
  {
    return width/14 + (2*(int)random(0,8))*width/14 -w/2;
  }
  
  public boolean isDead ()
  {
    return kill;
  }
  
  public boolean collide (float x, float y, float w, float h)
  {
    if (pos.x > x && pos.y > y && pos.x < x+w && pos.y < y+h) return true;
    
    return false;
  }
  
  public void changeColor (color c)
  {
    this.c = c; 
  }
  
}
