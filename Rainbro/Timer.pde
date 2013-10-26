public class Timer {
  
  private int startTime;
  private int totalTime;
  
  Timer (int totalTime)
  {
    this.totalTime = totalTime;
  }
  
  public void start ()
  {
    startTime = millis();
  }
  
  public void stop ()
  {
  }
  
  public boolean isDone ()
  {
    if ((millis() - startTime) > totalTime) return true;
    
    return false;
  }
  
}
