public class Filter {
  
  public float w,x,y,h;
  public PVector pos;
  private PVector dest;
  private Colors colors = new Colors();
  private color c = color(0,255,255);
  private int colorIndex = 0;
  private float speed = .4; // needs to be < 1
  
  Filter (float x, float y, float w, float h)
  {
    this.pos = new PVector(0,0);
    this.dest = new PVector(0,0);
    this.pos.x = x;
    this.pos.y = y;
    this.dest.y = pos.y;
    this.w = w;
    this.h = h;
    
    c = colors.getColor(colorIndex);
  }
  
  private void move (int dir)
  {
    if (pos.x != dest.x) return;
    
    if (dir == 1) 
    { 
      if (pos.x < width-w) dest.x = pos.x + w;
    }
    else 
    {
      if (pos.x > 0) dest.x = pos.x - w; 
    }

  }
  
  public void update ()
  {
    drawFilter ();
  }
  
  private void drawFilter ()
  {
    fill(c);
    
    pos.lerp(dest, speed);
    
    if (abs(pos.x - dest.x) < 2) pos.x = dest.x;
    
    rect (pos.x, pos.y, w, h);
  }
  
  public void changeColor (int i)
  {
    colorIndex += i;
    if (colorIndex < 0) colorIndex = 6;
    else if (colorIndex > 6) colorIndex = 0;
    
    c = colors.getColor(colorIndex);
  }
  
  public color getColor ()
  {
    return this.c;
  }
  
}
