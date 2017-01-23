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
  
 public World()
 {
   roadComponents = new RoadComponent[BUFSIZE];
   
 }
 
 public void extendWorld()
 {
   int i = 1;
   while((yOffset + height) >= worldHeight)
   {
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
 }
 
 public boolean addRoadComponent(RoadComponent c)
 {
   if(end == (start - 1))
     return false;
     
   worldHeight += c.getScreenHeight();
     
   end = (end + 1) % BUFSIZE;
   roadComponents[end] = c;
   
   if(start == -1)
     start = 0;
   
   return true;
 }
 
 public boolean removeRoadComponent()
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
   //println("Start: " + start + "; End: " + end);
   
   int i = start;
   
   while(i <= (start + abs(end - start)))
   {
     roadComponents[i].render(yOffset);
     i = (i + 1) % BUFSIZE;
   }
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
       int type = (int)(random(0, 100) % 2);
       if(type == 0)
         addRoadComponent(new StraightRoad(roadComponents[end].getRoadConnectionEnd(), roadComponents[end].getEndWidth(), KDir.UP, random(25, 200), random(25, 150)));
       else
         addRoadComponent(new KArc(roadComponents[end].getRoadConnectionEnd(), roadComponents[end].getEndWidth(), KArcType.values()[(int)(random(0, 100) % 2)]));
       break;
     }
     case LEFT:
     {
       int type = (int) (random(0, 100) % 2);
       
       if(type == 0)
         addRoadComponent(new StraightRoad(roadComponents[end].getRoadConnectionEnd(), roadComponents[end].getEndWidth(), KDir.LEFT, random(25, 200), random(25, 150)));
       else
         addRoadComponent(new KArc(roadComponents[end].getRoadConnectionEnd(), roadComponents[end].getEndWidth(), KArcType.UFL));
       break;
     }
     case RIGHT:
     {
       int type = (int) (random(0, 100) % 2);
       
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
   //addRoadComponent(new StraightRoad(roadComponents[end].getRoadConnectionEnd(), roadComponents[end].getEndWidth(), KDir.UP , random(25, 100), random(25, 100)));
 }
}