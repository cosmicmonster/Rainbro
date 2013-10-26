public class Bucket {
  
  /// COME UP WITH BETTER NAME GEEZE
  private float x, y, w,h;
  private color c;
  
  Bucket (float x, float y, float w, float h, color c)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c = c;
    
    //println(w);
  }
  
  public void update ()
  {
    noStroke();
    fill(c);
    rect (x, y, w, h);
  }
  
  public void addColor (float amount)
  {
    h += amount;
  }
  
  public void removeColor (float amount)
  {
    if (h > 0) h -= amount;
    
    if(h < 0) h = 0;
  }  
}
