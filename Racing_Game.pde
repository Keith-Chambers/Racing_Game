PVector arc_origin = new PVector(50, 50);
KArc test, test2;
StraightRoad sr1, sr2;
World world;

void setup()
{
  size(1000, 700);
  
  int yOffset = 0;
  
  world = new World();
  
  test = new KArc(new PVector(width/2, height), 120, KArcType.L);
  test2 = new KArc(test.getRoadConnectionEnd(), 120, KArcType.UFL);
  
  sr1 = new StraightRoad(new PVector(width/2, height), 120, KDir.UP, 120, 50);
  sr2 = new StraightRoad(sr1.getRoadConnectionEnd(), 50, KDir.UP, 100, 100);
  
  //world.addRoadComponent( (RoadComponent) test);
  //world.addRoadComponent( (RoadComponent) test2);
  world.addRoadComponent( (RoadComponent) sr1);
  world.addRoadComponent( (RoadComponent) sr2);
  
  world._setYOffset(yOffset);
  world.extendWorld();
  world.render();
  
  /*
  if(world._lastComponentBelowScreen() == true)
  {
    println("Last component off screen");
    world.removeRoadComponent();
  }else
  {
    println("Still on screen");
  }
  */
}

void mousePressed()
{
  if(test.contains(new PVector(mouseX, mouseY)))
    println("Arc Clicked");
  else
    println("Not Clicked");
}

void draw()
{
  
}