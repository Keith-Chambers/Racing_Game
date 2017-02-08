PVector arc_origin = new PVector(50, 50);
World world;
Car car;
PVector startLoc;
float carYOffset;
boolean startGame = false;
boolean endGame = false;

int yOffset = 0;

void setup()
{
  size(1000, 700);

  world = new World();
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
    if(key == 'p')
    {
      println("P Pressed");
      startGame = true;
    }
}

void mousePressed()
{
  if(world.findTheComponent(new PVector(mouseX, mouseY)) == false)
    endGame = true;
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
    if(frameCount % 30 == 0)
    {
      background(220, 220, 220);
      world.extendWorld();
      world.render();
      //car.render();
      //world.incYOffset((int)car.moveTowards(new PVector(mouseX, mouseY), 5));
      
      
      /*
      if(!world.inWorld(car.getLocation()))
        println("Not in world");
      */
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