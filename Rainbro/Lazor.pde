public class Lazor {
  
  private Colors colors = new Colors();
  private PVector pos;
  private float w, h;
  private boolean shoot = false;
  
  private Timer lazorTimer;
  
  Lazor (PVector pos, float w)
  {
    this.w = w;
    this.pos = pos;
    this.h = 0;
  }
  
  public void update ()
  {
     if (lazorTimer != null && lazorTimer.isDone())
     {
       shoot = false;
       h = lerp(h, 0, 0.5);
     }
     

    if (shoot)
    { 
      h = lerp(h, 800, 0.5);
    } 
    
    drawLazor();
  }
  
  private void drawLazor ()
  {
    for (int i =0; i < 7; i++)
    {
      fill (colors.getColor(i));
      
      //rect(pos.x + (w/7.0)*i, pos.y, w/7, -h-random(1,20));
      //rect(pos.x + (w/7.0)*i, pos.y, w/7, -h);
    }
  }
  
  public void shoot ()
  {
    lazorTimer = new Timer(1500);
    lazorTimer.start();
    h = 0;
    this.shoot = true;
  }
}
