public class Bucket {

  /// COME UP WITH BETTER NAME GEEZE
  private float w, h, tempH;
  private PVector pos;
  private color c;
  private final int maxColor = 60;
  
  Bucket ()
  {

  }
  
  Bucket (float x, float y, float w, float h, color c)
  {
    pos = new PVector(0, 0);
    this.pos.x = x;
    this.pos.y = y;
    this.w = w;
    this.tempH = h;
    this.c = c;
  }

  public void update ()
  {
    noStroke();
    fill(c);
    
    if (abs(h - tempH) > 5) h = lerp(h, tempH, .1);
    else h = tempH;
    
    updatePosition ();
    
    rect (pos.x, pos.y, w, h);
  }

  public void addColor (float amount)
  {
    this.tempH+=amount;

    if (this.tempH < 0) this.tempH = 0;
  }

  public void removeColor (float amount)
  {
    if (this.tempH > 0) this.tempH -= amount;

    if (this.tempH < amount) this.tempH = 0;
    
    //println("Amount: " + amount + " - Height: " + this.h);
  }

  private void updatePosition ()
  {
    pos.y = height - h;
  }

  public color getColor ()
  {
    return c;
  }
  
  public float getHeight ()
  {
    return this.tempH;
  }
  
  public boolean collide (float x, float y, float w, float h)
  {
    if (pos.x > x && pos.y > y && pos.x < x+w && pos.y < y+tempH) return true;

    return false;
  }
}

