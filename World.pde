class World
{
  int baseHeight = 0;
  int worldHeight = 0;
  RoadComponent[] roadComponents;
  
  // CircBuf
  int back = -1;
  int front = 0;
  int size = 0;
  final int BUFSIZE = 30;
  
  PVector startLoc = new PVector(width / 2, height - 20);
  int yOffset = 0;
  
  // Map generation data
  int roadLenMax = 200;
  int roadLenMin = 20;
  final int SIDEPADDING = 50;
  
 public World()
 {
   roadComponents = new RoadComponent[BUFSIZE];
   
 }
 
 public void extendWorld()
 {
   println("extendWorld()");
   println("  yOffset: " + yOffset);
   println("  height: " + height);
   println("  worldHeight: " + worldHeight);
   println();
   
   while((yOffset + height) >= worldHeight)
   {
     println("Adding RoadComponent");
     generateNewRoadComponent();
   }
   
   cleanRoadComponentsData();
   
   println("World doesn't need to be extended");
 }
 
 public boolean addRoadComponent(RoadComponent c)
 {
   if(size == BUFSIZE)
   {
     println("Failed to add another RoadComponent");
     return false;
   }
   
   worldHeight += c.getScreenHeight();
     
   back = (back + 1) % BUFSIZE;
   roadComponents[back] = c;
   
   size++;
   
   return true;
 }
 
 private RoadComponent getLastRoadComponent()
 {
   return roadComponents[back];
 }
 
 public void cleanRoadComponentsData()
 {
   println("Cleaning Road Component Data");
   while(getLastRoadComponent().belowScreen(yOffset) == true)
   {
     println("Removing RoadComponent from bottom on screen");
     removeRoadComponent();
   }
   
   println("Clean Complete");
 }
 
 private boolean removeRoadComponent()
 {
   if(size == 0)
     return false;
     
   worldHeight -= roadComponents[front].getScreenHeight();
   roadComponents[front++] = null; 
   front %= BUFSIZE;
   size--;
   
   return true;
 }
 
 public int getWorldHeight()
 {
   int result = 0;
   int i = front;
   
   while(i != ((back + 1)%BUFSIZE))
   {
     result += roadComponents[i].getScreenHeight();
     i = (i + 1) % BUFSIZE;
   }
   
   return result;
 }
 
 public void render()
 {
   
   int i = front;
   
   while(i != (back+1)%BUFSIZE)
   {
     roadComponents[i].render(yOffset);
     println("Rendering component #" + ((i + 1) % BUFSIZE));
     i = (i + 1) % BUFSIZE;
   }
   
   println("Render cycle complete");
 } // End render()
 
 public void _setYOffset(int _yOffset)
 {
   yOffset = _yOffset;
 }
 
 public boolean _lastComponentBelowScreen()
 {
   return roadComponents[front].belowScreen(yOffset);
 }
 
 public void generateNewRoadComponent()
 {
   println("Generating new road component");
   switch(roadComponents[back].getDirection())
   {
     case UP:
     {
       println("UP called");
       int type = (int)(random(0, 100) % 2);
       if(type == 0)
         addRoadComponent(new StraightRoad(roadComponents[back].getRoadConnectionEnd(), roadComponents[back].getEndWidth(), KDir.UP, random(25, 200), random(25, 150)));
       else
         addRoadComponent(new KArc(roadComponents[back].getRoadConnectionEnd(), roadComponents[back].getEndWidth(), KArcType.values()[(int)(random(0, 100) % 2)]));
       break;
     }
     case LEFT:
     {
       println("Left Called");
       int type = (int) (random(0, 100) % 2);
       int roadLen = -1;
       
       while(roadLen == -1 || (roadComponents[back].roadConnectionStart.x - roadLen - SIDEPADDING) < 0)
       {
         roadLen = (int) random(25, 200);
         if(roadComponents[back].roadConnectionStart.x + (roadComponents[back].getEndWidth()/2) + SIDEPADDING >= width)
         {
           type = 1;
           break;
         }
       }
       
       if(type == 0)
         addRoadComponent(new StraightRoad(roadComponents[back].getRoadConnectionEnd(), roadComponents[back].getEndWidth(), KDir.LEFT, random(25, 200), random(25, 150)));
       else
         addRoadComponent(new KArc(roadComponents[back].getRoadConnectionEnd(), roadComponents[back].getEndWidth(), KArcType.UFL));
       break;
     }
     case RIGHT:
     {
       println("Right Called");
       int type = (int) (random(0, 100) % 2);
       int roadLen = -1;
       
       while(roadLen == -1 || (roadLen + roadComponents[back].roadConnectionStart.x + SIDEPADDING) > width)
       {
         roadLen = (int) random(25, 200);
         if(roadComponents[back].roadConnectionStart.x + (roadComponents[back].getEndWidth()/2) + SIDEPADDING >= width)
         {
           type = 1;
           break;
         }
       }
       
       if(type == 0)
         addRoadComponent(new StraightRoad(roadComponents[back].getRoadConnectionEnd(), roadComponents[back].getEndWidth(), KDir.RIGHT, random(25, 200), random(25, 150)));
       else
         addRoadComponent(new KArc(roadComponents[back].getRoadConnectionEnd(), roadComponents[back].getEndWidth(), KArcType.UFR));
       break;
     }
     default:
       println("Default case called in World.generateNewRoadComponent()");
       return;
   }
 }
}