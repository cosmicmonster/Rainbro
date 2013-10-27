public class Splash {
  
  private ArrayList<Particle> particles;
  private Timer timer;
  public boolean kill = false;
  
  Splash (PVector pos, float size)
  {
    timer = new Timer(5000);
    timer.start();
    particles = new ArrayList<Particle>();
  
    for (int i = 0; i < size; i++)
    {
      particles.add(new Particle(pos.x,pos.y,3));
    }
  }

  Splash (PVector pos, float size, color c)
  {
    timer = new Timer(5000);
    timer.start();
    
    particles = new ArrayList<Particle>();
  
    for (int i = 0; i < size; i++)
    {
      particles.add(new Particle(pos.x,pos.y,3, c));
    }
  }
  
  public void update ()
  {
    if (timer.isDone()) kill = true;
    
    for(int i=0; i < particles.size(); i++)
    {
      particles.get(i).update();
    }
  }
}

public class Particle
{
  PVector pos;
  PVector dir = new PVector(random(-4,4),random(-4,4));
  PVector gravity = new PVector(0,1);
  
  Colors colors = new Colors();
  
  color c;
  float size;
  boolean kill = false;
  
  Timer timer;
  
  Particle (float x, float y, float size)
  {
    //gravity.normalize();
    timer = new Timer(2000);
    timer.start();
    pos = new PVector(x,y);
    this.size = size;
    c= colors.getColor((int)random(0,7));
  }
  
  Particle (float x, float y, float size, color c)
  {
    //gravity.normalize();
    timer = new Timer(2000);
    timer.start();
    pos = new PVector(x,y);
    this.size = size * random (.5,1.5);
    this.c = c;
    dir.mult(2);
  }  
  
  public void update ()
  {
    if (timer.isDone()) kill = true;
    
    dir.mult(.95);
    pos.add(dir);
    gravity.mult(1.05);
    pos.add(gravity);
    
    drawParticle ();
  }
  
  private void drawParticle ()
  {
    fill(c);
    ellipse (pos.x, pos.y, size, size);
  }
  
  public boolean isDead ()
  {
    return kill;
  }
  
}
