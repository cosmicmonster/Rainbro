public class Rainbow {
  
  private Colors colors = new Colors();
  private ArrayList<Bucket> buckets;
  private boolean gameOver = false;
  
  Rainbow () {
    createBuckets ();
  }
  
  private void createBuckets ()
  {
    buckets = new ArrayList<Bucket>();
    
    for (int i = 0; i < (float)width/7.0; i++)
    {
      buckets.add(new Bucket(i*(width/7.0), height-20, width/7.0, 20, colors.getColor(i))); 
    }
  }
  
  public void update ()
  {
    updateBuckets ();
  }
  
  private void updateBuckets ()
  {
    for (int i = 0; i < buckets.size(); i++)
    {
      buckets.get(i).update();
      if (buckets.get(i).h <= 0) { 
        //println("--" + buckets.get(i).h);
        gameOver = true;
      }
    }
  }
  
  public boolean isEpic ()
  {
    return false;
  }
  
  public ArrayList<Bucket> getBuckets ()
  {
    return buckets;
  }
  
  public boolean checkGameOver ()
  {
    return gameOver;
  }
}

public class Colors {
  
  public color red = color (255,0,0);
  public color orange = color (255,127,0);
  public color yellow = color (255,255,0);
  public color green = color (0,255,0);
  public color blue = color (0,0,255);
  public color indigo = color (75,0,130);
  public color violet = color (143,0,255);
  
  Colors () 
  {
    
  }
  
  // This is ugly, but I don't care
  public color getColor(int i)
  {
    switch(i) 
    {
    case 0: return red;
    case 1: return orange;
    case 2: return yellow;
    case 3: return green;
    case 4: return blue;
    case 5: return indigo;
    case 6: return violet;
    default: return color(255,0,255);
    }
  }
}
