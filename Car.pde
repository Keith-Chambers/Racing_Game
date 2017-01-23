class Car
{
  
  int speed;
  float direction;
  PVector loc;
  PShape shape;
  
  final int carWidth = 60;
  final int carHeight = 100;
  
  color c;
  
  public Car(PVector _loc, float _direction) 
  {
    speed = 0;
    loc = _loc;
    direction = _direction;
    shape = createShape();
    
    //loc = new PVector(width/2, height/2);
    shape.beginShape(RECT);
    shape.vertex(loc.x - carWidth/2, loc.y - carHeight/2);
    shape.vertex(loc.x + carWidth/2, loc.y - carHeight/2);
    shape.vertex(loc.x + carWidth/2, loc.y + carHeight/2);
    shape.vertex(loc.x - carWidth/2, loc.y + carHeight/2);
    shape.rotate(direction);
    shape.fill(0, 0, 100);
    shape.endShape();
  }
  
  public void render()
  {
    shape(shape, 0, 0);
  }
  
  
}