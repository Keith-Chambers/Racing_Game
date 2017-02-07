class Car
{
  
  int speed;
  float direction;
  PVector loc;
  PShape car;
  color mainColour;
  
  final int carWidth = 15;
  final int carHeight = 25;
  
  color c;
  
  public Car(PVector _loc, float _direction) 
  {
    speed = 0;
    mainColour = color(200, 200, 100);
    loc = _loc;
    direction = _direction;
    car = createShape();
    //loc = new PVector(0, 0);

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

  }
  
  public void render()
  {
    println("Rendering car");
    shape(car, 0, 0);
  }
  
  
}