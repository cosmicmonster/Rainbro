public class Bucket {

  /// COME UP WITH BETTER NAME GEEZE
  private float w, h;
  private PVector pos;
  private color c;
  private final int maxColor = 60;

  Bucket (float x, float y, float w, float h, color c)
  {
    pos = new PVector(0, 0);
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
    this.h+=amount;

    if (this.h < 0) this.h = 0;

    updatePosition ();
  }

  public void removeColor (float amount)
  {
    if (this.h > 0) this.h -= amount;

    if (this.h < amount) this.h = 0;
    
    //println("Amount: " + amount + " - Height: " + this.h);
    
    updatePosition ();
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
    return this.h;
  }
  
  public boolean collide (float x, float y, float w, float h)
  {
    if (pos.x > x && pos.y > y && pos.x < x+w && pos.y < y+h) return true;

    return false;
  }
}

