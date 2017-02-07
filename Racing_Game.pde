PVector arc_origin = new PVector(50, 50);
KArc test, test2;
StraightRoad sr1, sr2;
World world;
Car car;
PVector startLoc;

int yOffset = 0;

void setup()
{
  size(1000, 700);

  world = new World();
  startLoc = new PVector();
  
  startLoc = world.getNextRoadComponent().roadConnectionStart;
  startLoc.y -= 20;
  car = new Car(startLoc, radians(90));

  world._setYOffset(yOffset);
  yOffset += 10;
  world.extendWorld();
  world.render();
  car.render();
}

void draw()
{

  if(false)
  {
    background(200);
    world._setYOffset(yOffset);
    yOffset += 10;
    world.extendWorld();
    world.render();
  }
}