public class Splash {
  
  private ArrayList<Particle> particles;
  
  Splash (float x, float y, float size)
  {
    particles = new ArrayList<Particle>();
  
    for (int i = 0; i < size; i++)
    {
      particles.add(new Particle(x,y,3));
    }
  }
  
  public void update ()
  {
    for(int i=0; i < particles.size(); i++)
    {
      particles.get(i).update();
    }
  }
}

public class Particle
{
  PVector pos;
  PVector dir = new PVector(random(0,4),random(0,4));
  PVector gravity = new PVector(0,1);
  
  float size;
  boolean kill = false;
  
  Timer timer;
  
  Particle (float x, float y, float size)
  {
    gravity.normalize();
    timer = new Timer(2000);
    timer.start();
    pos = new PVector(x,y);
    this.size = size;
  }
  
  public void update ()
  {
    if (timer.isDone()) kill = true;
    
    pos.add(gravity);
    pos.add(dir);
    
    drawParticle ();
  }
  
  private void drawParticle ()
  {
    ellipse (pos.x, pos.y, size, size);
  }
  
  public boolean isDead ()
  {
    return kill;
  }
  
}
