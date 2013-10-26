public class Bucket {
  
  /// COME UP WITH BETTER NAME GEEZE
  private float w,h;
  private PVector pos;
  private color c;
  private final int maxColor = 40;
  
  Bucket (float x, float y, float w, float h, color c)
  {
    pos = new PVector(0,0);
    this.pos.x = x;
    this.pos.y = y;
    this.w = w;
    this.h = h;
    this.c = c;
  }
  
  public void update ()
  {
    noStroke();
    fill(c);
    rect (pos.x, pos.y, w, h);
  }
  
  public void addColor (float amount)
  {
    if (h < maxColor) h += amount;
    
    if (h > maxColor) h = maxColor;
  }
  
  public void removeColor (float amount)
  {
    if (h > 0) h -= amount;
    
    if(h < 0) h = 0;
  }
  
  public boolean collide (float x, float y, float w, float h)
  {
    if (pos.x > x && pos.y > y && pos.x < x+w && pos.y < y+h) return true;
    
    return false;
  }  
}
