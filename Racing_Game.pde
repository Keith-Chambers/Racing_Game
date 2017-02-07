PVector arc_origin = new PVector(50, 50);
KArc test, test2;
StraightRoad sr1, sr2;
World world;

int yOffset = 0;

void setup()
{
  size(1000, 700);

  world = new World();
  
  sr1 = new StraightRoad(new PVector(width/2, height), 120, KDir.UP, 120, 50);
  
  //world.addRoadComponent( (RoadComponent) sr1);
  
  /*
  for(int i = 0; i < 10; i++)
  {
    println("Frame #" + (i + 1));
  }
   */
}

void draw()
{

  if(frameCount % 15 == 0)
  {

    background(200);
    world._setYOffset(yOffset);
    yOffset += 20;
    world.extendWorld();
    world.render();
  }
}