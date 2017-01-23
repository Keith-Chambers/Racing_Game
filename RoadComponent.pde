public abstract class RoadComponent
{
  PVector roadConnectionStart;
  float startWidth;
  KDir direction;
  color colour = color(50);
  
  public RoadComponent(PVector _roadConnectionStart, float _startWidth, KDir _direction)
  {
    roadConnectionStart = _roadConnectionStart;
    startWidth = _startWidth;
    direction = _direction;
  }
  
  public void setColour(color _colour)
  {
    colour = _colour;
  }
  
  // Needs to be overridden
  public abstract KDir getDirection();
  public abstract PVector getRoadConnectionEnd();
  public abstract boolean contains(PVector p);
  public abstract float getScreenHeight();
  public abstract float getTrackLenght();
  public abstract float getEndWidth();
  public abstract void render(int yOffset); 
  public abstract boolean belowScreen(int yOffset);
}