PVector arc_origin = new PVector(50, 50);
KArc test, test2;
StraightRoad sr1, sr2;
World world;
Car car;
PVector startLoc;
float carYOffset;

int yOffset = 0;

void setup()
{
  size(1000, 700);

  world = new World();
  //startLoc = new PVector(world.getNextRoadComponent().getRoadConnectionEnd().x, world.getNextRoadComponent().getRoadConnectionEnd().y + 20);
  carYOffset = world.getNextRoadComponent().getTrackLenght();
  startLoc = new PVector(world.getNextRoadComponent().roadConnectionStart.x, world.getNextRoadComponent().roadConnectionStart.y - carYOffset);
  car = new Car(startLoc, radians(90));
  world._setYOffset(0);
  
}

void keyPressed()
{
  if(keyPressed)
    if(key == 'q')
      exit();
      
}

void draw()
{

  if(frameCount % 1 == 0)
  {
    background(220, 220, 220);
    //world._setYOffset((int)(car.getLocation().y + carYOffset - height));
    world.extendWorld();
    world.render();
    car.render();
    world.incYOffset((int)car.moveTowards(new PVector(mouseX, mouseY), 5));
  }
}