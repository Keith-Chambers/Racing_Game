class Car
{
  private PVector loc;
  private color mainColour;
  private float radius = 10;
  
  final int carWidth = 15;
  final int carHeight = 15;
  
  color c;
  
  public Car(PVector _loc) 
  {
    mainColour = color(200, 200, 100);
    loc = _loc;
  }
  
  public void moveForward()
  {
    loc.y += 20;
  }
  
  public float moveTowards(PVector target, int speed)
  {
    float dx, dy, ix, iy, dist, ratio;
    dx = target.x - loc.x;
    dy = target.y - loc.y;
    dist = dist(target.x, target.y, loc.x, loc.y);
    ratio = speed / dist; // Less than 1
    ix = dx * ratio;
    iy = dy * ratio;
    
    loc.x += ix;
    
    return iy * -1;
  }
  
  public PVector getLocation()
  {
    return loc;
  }
  
  public void render()
  {
    fill(mainColour);
    if(radius == 0)
      radius = 1;
    ellipse(loc.x, loc.y, radius*2, radius*2);
    
    /*
    car = createShape();
    car.beginShape();
    car.fill(mainColour);
    car.stroke(1);
    // Top Left
    car.vertex(loc.x - carWidth/2, loc.y - carHeight/2);
    // Top Right
    car.vertex(loc.x + carWidth/2, loc.y - carHeight/2);
    // Bottom Right
    car.vertex(loc.x + carWidth/2, loc.y + carHeight/2);
    // Bottom Left
    car.vertex(loc.x - carWidth/2, loc.y + carHeight/2);
    // END
    //shape.vertex(loc.x - carWidth/2, loc.y - carHeight/2);
    //shape.rotate(direction);
    
    car.endShape(CLOSE);
    
    println("Rendering car");
    shape(car, 0, 0);
    */
  }
  
  
}