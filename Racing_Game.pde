PVector arc_origin = new PVector(50, 50);
World world;
Car car;
PVector startLoc;
float carYOffset;
boolean startGame = false;
boolean endGame = false;
int carSpeed = 5;

int yOffset = 0;

void setup()
{
  size(1000, 700);

  world = new World();
  carYOffset = world.getNextRoadComponent().getTrackLenght();
  startLoc = new PVector(world.getNextRoadComponent().roadConnectionStart.x, world.getNextRoadComponent().roadConnectionStart.y - carYOffset);
  car = new Car(startLoc);
  world._setYOffset(0);
  
}

void keyPressed()
{
  if(keyPressed)
    if(key == 'q')
      exit();
    if(key == 'p')
    {
      startGame = true;
    }
}

void mousePressed()
{
}

void draw()
{
  
  if(!startGame)
  {
    background(220, 220, 220);
    textSize(40);
    fill(0);
    textAlign(CENTER);
    text("Press p to begin", width/2, height/2);
   
  }else if(startGame == true && endGame == false)
  {
    if(frameCount % 2 == 0)
    {
      background(220, 220, 220);
      world.extendWorld();
      world.render();
      car.render();
      world.incYOffset((int)car.moveTowards(new PVector(mouseX, mouseY), carSpeed));
      if(world.findTheComponent(new PVector(car.getLocation().x, car.getLocation().y - world.getYOffset())) == false)
        endGame = true;
    }
  }else
  {
    background(220, 220, 220);
    textSize(40);
    fill(0);
    textAlign(CENTER);
    text("Game Over!", width/2, height/2);
  }
}