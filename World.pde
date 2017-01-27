class World
{
  int baseHeight = 0;
  int worldHeight = 0;
  RoadComponent[] roadComponents;
  int end = -1;
  int start = -1;
  final int BUFSIZE = 50;
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
     // Generate Component
     if(start == 0 && end == -1)
     {
       // Generate first roadComponent
       addRoadComponent(new StraightRoad(startLoc, 50, KDir.UP, 100, 50));
     }else
     {
       generateNewRoadComponent();
     }
   }
   
   cleanRoadComponentsData();
   
   println("World doesn't need to be extended");
 }
 
 public boolean addRoadComponent(RoadComponent c)
 {
   if(end == (start - 1))
   {
     println("Failed to add another RoadComponent");
     return false;
   }
   
   worldHeight += c.getScreenHeight();
     
   end = (end + 1) % BUFSIZE;
   roadComponents[end] = c;
   
   if(start == -1)
     start = 0;
   
   return true;
 }
 
 private RoadComponent getLastRoadComponent()
 {
   return roadComponents[start];
 }
 
 public void cleanRoadComponentsData()
 {
   while(getLastRoadComponent().belowScreen(yOffset) == true)
   {
     removeRoadComponent();
     println("Removing RoadComponent from bottom on screen");
   }
 }
 
 private boolean removeRoadComponent()
 {
   if(start == -1 || (end + 1) == start)
     return false;
     
   worldHeight -= roadComponents[start].getScreenHeight();
   roadComponents[start++] = null; 
   start %= BUFSIZE;
   
   return true;
 }
 
 public int getWorldHeight()
 {
   int result = 0;
   int i = start;
   
   while(i <= (start + abs(end - start)))
   {
     result += roadComponents[i].getScreenHeight();
     i = (i + 1) % BUFSIZE;
   }
   
   return result;
 }
 
 public void render()
 {
   
   int i = start;
   
   while(i <= (start + abs(end - start)))
   {
     roadComponents[i].render(yOffset);
     println("Rendering component #" + (i + 1));
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
   return roadComponents[start].belowScreen(yOffset);
 }
 
 public void generateNewRoadComponent()
 {
   switch(roadComponents[end].getDirection())
   {
     case UP:
     {
       println("UP called");
       int type = (int)(random(0, 100) % 2);
       if(type == 0)
         addRoadComponent(new StraightRoad(roadComponents[end].getRoadConnectionEnd(), roadComponents[end].getEndWidth(), KDir.UP, random(25, 200), random(25, 150)));
       else
         addRoadComponent(new KArc(roadComponents[end].getRoadConnectionEnd(), roadComponents[end].getEndWidth(), KArcType.values()[(int)(random(0, 100) % 2)]));
       break;
     }
     case LEFT:
     {
       println("Left Called");
       int type = (int) (random(0, 100) % 2);
       int roadLen = -1;
       
       while(roadLen == -1 || (roadComponents[end].roadConnectionStart.x - roadLen - SIDEPADDING) < 0)
       {
         roadLen = (int) random(25, 200);
         if(roadComponents[end].roadConnectionStart.x + roadComponents[end].getEndWidth() + SIDEPADDING >= width)
         {
           type = 1;
           break;
         }
       }
       
       if(type == 0)
         addRoadComponent(new StraightRoad(roadComponents[end].getRoadConnectionEnd(), roadComponents[end].getEndWidth(), KDir.LEFT, random(25, 200), random(25, 150)));
       else
         addRoadComponent(new KArc(roadComponents[end].getRoadConnectionEnd(), roadComponents[end].getEndWidth(), KArcType.UFL));
       break;
     }
     case RIGHT:
     {
       println("Right Called");
       int type = (int) (random(0, 100) % 2);
       int roadLen = -1;
       
       while(roadLen == -1 || (roadLen + roadComponents[end].roadConnectionStart.x + SIDEPADDING) > width)
       {
         roadLen = (int) random(25, 200);
         if(roadComponents[end].roadConnectionStart.x + roadComponents[end].getEndWidth() + SIDEPADDING >= width)
         {
           type = 1;
           break;
         }
       }
       
       if(type == 0)
         addRoadComponent(new StraightRoad(roadComponents[end].getRoadConnectionEnd(), roadComponents[end].getEndWidth(), KDir.RIGHT, random(25, 200), random(25, 150)));
       else
         addRoadComponent(new KArc(roadComponents[end].getRoadConnectionEnd(), roadComponents[end].getEndWidth(), KArcType.UFR));
       break;
     }
     default:
       println("Default case called in World.generateNewRoadComponent()");
       return;
   }
 }
}