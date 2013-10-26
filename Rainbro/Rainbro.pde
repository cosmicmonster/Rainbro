private Rain rain;
private Rainbow rainbow;
private Filter filter;


void setup () {
  
  size (500,720);
  frameRate(60);
  load ();
}

void load ()
{
  rain = new Rain();
  rainbow = new Rainbow();
  filter = new Filter(0, height-60, width/7.0, 20);
}

void update ()
{
  rain.update ();
  rainbow.update ();
  filter.update ();
  checkCollisions ();
}


void checkCollisions ()
{
  if (rain.collide(filter.pos.x, filter.pos.y, filter.w, filter.h)) println("a drain drop hit filter");
}

void draw () {
  background(25,25,25);
  update ();
}

void keyPressed ()
{
  if (key == CODED) 
  {
    if (keyCode == LEFT) filter.move(-1);
    else if (keyCode == RIGHT) filter.move(1);
  }
}
