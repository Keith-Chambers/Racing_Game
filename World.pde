class World
{
  int baseHeight = 0;
  int worldHeight = 0;
  RoadComponent[] roadComponents;
  
  int temp = 1;
  
  // CircBuf
  int back = -1;
  int front = 0;
  int size = 0;
  final int BUFSIZE = 30;
  
  final int ROADPADDING = 100;
  PVector startLoc = new PVector(width / 2, height - 20);
  int yOffset = 0;
  
  // Map generation data
  int roadLenMax = 200;
  int roadLenMin = 20;
  final int SIDEPADDING = 50;
  
 public World()
 {
   roadComponents = new RoadComponent[BUFSIZE];
   
   for(int i = 0; i < BUFSIZE; i++)
     roadComponents[i] = null;
 }
 
 public void extendWorld()
 {
   /*
   println("extendWorld()");
   println("  yOffset: " + yOffset);
   println("  height: " + height);
   println("  worldHeight: " + worldHeight);
   println("  bufferSize: " + size);
   println();
   */
   
   
   
   while(size == 0 || (getLastRoadComponent().getRoadConnectionEnd().y > -yOffset))
   {
     println(temp + ") Adding RoadComponent");
     temp++;
     generateNewRoadComponent();
   }
   
   cleanRoadComponentsData();
   
   //println("World doesn't need to be extended");
 }
 
 public boolean addRoadComponent(RoadComponent c)
 {
   if(size == BUFSIZE)
   {
     println("Failed to add another RoadComponent");
     exit();
   }
   
   worldHeight += c.getScreenHeight();
     
   back = (back + 1) % BUFSIZE;
   roadComponents[back] = c;
   
   size++;
   
   //println("Adding roadComponent, size = " + size + ": StartY = " + c.roadConnectionStart.y);
   
   return true;
 }
 
 private RoadComponent getLastRoadComponent()
 {
   if(back < 0) 
     exit();
     
   return roadComponents[back];
 }
 
 private RoadComponent getNextRoadComponent()
 {
   return roadComponents[front];
 }
 
 public void cleanRoadComponentsData()
 {
   //println("Cleaning Road Component Data");
   while(size != 0 && (getNextRoadComponent().belowScreen(yOffset) == true))
   {
     //println("Removing RoadComponent from bottom on screen");
     removeRoadComponent();
   }
   
   //println("Clean Complete");
 }
 
 private boolean removeRoadComponent()
 {
   if(size == 0)
   {
     println("Trying to remove an element from an empty circ buffer");
     exit();
   }
     
   worldHeight -= roadComponents[front].getScreenHeight();
   roadComponents[front++] = null; 
   front %= BUFSIZE;
   size--;
   
   //println("Removing Component, Size = " + size);
   
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
     //println("Rendering component #" + ((i + 1) % BUFSIZE));
     i = (i + 1) % BUFSIZE;
   }
   
   //println("Render cycle complete");
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
   RoadComponent next;
   KDir dir;
   float startWidth;
   PVector startLoc;
   
   if(back < 0 || roadComponents[back] == null)
   {
     dir = KDir.UP;
     startWidth = width / 10;
     startLoc = new PVector(width/2, height);
     println("GENERATING START COMPONENT");
   }
   else
   {
     dir = roadComponents[back].getDirection();
     startWidth = roadComponents[back].getEndWidth();
     startLoc = roadComponents[back].getRoadConnectionEnd();
   }
   
   do
   {
     //println("Testing new road component");
     switch(dir)
     {
       case UP:
       {
         //println("UP called");
         int type = (int)(random(0, 100) % 2);
         if(type == 0)
           next = new StraightRoad(startLoc, startWidth, KDir.UP, random(25, 200), random(25, 150));
         else
           next = new KArc(startLoc, startWidth, KArcType.values()[(int)(random(0, 100) % 2)]);
         break;
       }
       case LEFT:
       {
         //println("Left Called");
         int type = (int) (random(0, 100) % 2);
         int roadLen = -1;
         
         while(roadLen == -1 || (startLoc.x - roadLen - SIDEPADDING) < 0)
         {
           roadLen = (int) random(25, 200);
           if(startLoc.x + (startWidth/2) + SIDEPADDING >= width)
           {
             type = 1;
             break;
           }
         }
         
         if(type == 0)
           next = new StraightRoad(startLoc, startWidth, KDir.LEFT, random(25, 200), random(25, 150));
         else
           next = new KArc(startLoc, startWidth, KArcType.UFL);
         break;
       }
       case RIGHT:
       {
         //println("Right Called");
         int type = (int) (random(0, 100) % 2);
         int roadLen = -1;
         
         while(roadLen == -1 || (roadLen + startLoc.x + SIDEPADDING) > width)
         {
           roadLen = (int) random(25, 200);
           if(startLoc.x + (startWidth/2) + SIDEPADDING >= width)
           {
             type = 1;
             break;
           }
         }
         
         if(type == 0)
           next = new StraightRoad(startLoc, startWidth, KDir.RIGHT, random(25, 200), random(25, 150));
         else
           next = new KArc(startLoc, startWidth, KArcType.UFR);
         break;
       }
       default:
         println("Default case called in World.generateNewRoadComponent()");
         return;
     }
     
   }while(next.inHorizonRange(ROADPADDING) == false);
   
   //println("Adding to render list");
   addRoadComponent(next);
 }
}