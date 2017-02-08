class World
{
  int baseHeight = 0;
  int worldHeight = 0;
  RoadComponent[] roadComponents;
  
  // CircBuf
  int back = -1;
  int front = 0;
  int size = 0;
  int currentSegment = 0;
  final int BUFSIZE = 40;
  
  final int ROADPADDING = 100;
  PVector startLoc = new PVector(width / 2, height);
  int yOffset = 0;
  
  // Map generation data
  int roadLenMax = 200;
  int roadLenMin = 20;
  final int SIDEPADDING = 50;
  float trackLength;
  
 public World()
 {
   roadComponents = new RoadComponent[BUFSIZE];
   
   for(int i = 0; i < BUFSIZE; i++)
     roadComponents[i] = null;
     
   addRoadComponent(new StraightRoad(startLoc, 80, KDir.UP, 200, 80));
 }
 
 public void extendWorld()
 {
   /* For debugging
   println("extendWorld()");
   println("  yOffset: " + yOffset);
   println("  height: " + height);
   println("  worldHeight: " + worldHeight);
   println("  bufferSize: " + size);
   println();
   */
   
   
   while(size == 0 || (getLastRoadComponent().getRoadConnectionEnd().y > -yOffset))
   {
     generateNewRoadComponent();
   }
   
   cleanRoadComponentsData();
   
 }
 
 public boolean addRoadComponent(RoadComponent c)
 {
   if(size == BUFSIZE)
   {
     println("Failed to add another RoadComponent");
     exit();
   }
   
   worldHeight += c.getScreenHeight();
   trackLength += c.getTrackLenght();
   back = (back + 1) % BUFSIZE;
   roadComponents[back] = c;
   
   size++;
   
   return true;
 }
 public float getTrackLength()
 {
   return trackLength;
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
   while(size != 0 && (getNextRoadComponent().belowScreen(yOffset) == true))
   {
     removeRoadComponent();
   }
   
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
     i = (i + 1) % BUFSIZE;
   }
   
 } // End render()
 
 public void _setYOffset(int _yOffset)
 {
   if(_yOffset < yOffset)
     return;
   yOffset = _yOffset;
 }
 
 public boolean _lastComponentBelowScreen()
 {
   return roadComponents[front].belowScreen(yOffset);
 }
 
 public void incYOffset(int _yIncrement)
 {
     
   yOffset += _yIncrement;
 }
 
 public float getYOffset()
 {
   return yOffset;
 }
 
 public boolean inWorld(PVector _loc)
 {
   if(roadComponents[(front + currentSegment)%BUFSIZE].contains(_loc))
   {
     return true;
   }else
   {
     if(roadComponents[(front + currentSegment + 1)%BUFSIZE].contains(_loc))
     {
       currentSegment++;
       return true;
     }
     else 
       return false;
   }
   
 }
 
 public boolean findTheComponent(PVector p)
 {
   
   for(int i = 0; i < size; i++)
   {
     if(roadComponents[(front + i)%BUFSIZE].contains(p))
     {
       currentSegment = i;
       return true;
     }
   }
   
   return false;
 }
 
 public void generateNewRoadComponent()
 {
   RoadComponent next;
   KDir dir;
   float startWidth;
   PVector startLoc;
   
   dir = roadComponents[back].getDirection();
   startWidth = roadComponents[back].getEndWidth();
   startLoc = roadComponents[back].getRoadConnectionEnd();
   
   do
   {
     switch(dir)
     {
       case UP:
       {
         int type = (int)(random(0, 100) % 2);
         if(type == 0)
           next = new StraightRoad(startLoc, startWidth, KDir.UP, random(25, 200), random(25, 150));
         else
           next = new KArc(startLoc, startWidth, KArcType.values()[(int)(random(0, 100) % 2)]);
         break;
       }
       case LEFT:
       {
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
   
   addRoadComponent(next);
 }
}