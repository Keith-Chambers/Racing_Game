class StraightRoad extends RoadComponent
{
  float roadLength;
  float endWidth;
  PShape s;
  
  PVector BR_UP;
  PVector BL_UP;
  PVector TL_UP;
  PVector TR_UP;
  
  PVector BR_R;
  PVector BL_R;
  PVector TL_R;
  PVector TR_R;
  
  PVector BR_L;
  PVector BL_L;
  PVector TL_L;
  PVector TR_L;
  
  public StraightRoad(PVector _roadConnectionStart, float _startWidth, KDir _direction, float _roadLength, float _endWidth)
  {
    super(_roadConnectionStart, _startWidth, _direction);
    roadLength = _roadLength;
    endWidth = _endWidth;
    
    if(direction == KDir.UP)
    {
      BR_UP = new PVector(roadConnectionStart.x + startWidth/2, roadConnectionStart.y);
      BL_UP = new PVector(roadConnectionStart.x - startWidth/2, roadConnectionStart.y);
      TL_UP = new PVector(roadConnectionStart.x - endWidth/2, roadConnectionStart.y - roadLength);
      TR_UP = new PVector(roadConnectionStart.x + endWidth/2, roadConnectionStart.y - roadLength);
    }else if(direction == KDir.RIGHT)
    {
      BR_R = new PVector(roadConnectionStart.x + roadLength, roadConnectionStart.y + endWidth/2);
      BL_R = new PVector(roadConnectionStart.x, roadConnectionStart.y + startWidth/2);
      TL_R = new PVector(roadConnectionStart.x, roadConnectionStart.y - startWidth/2);
      TR_R = new PVector(roadConnectionStart.x + roadLength, roadConnectionStart.y - endWidth/2);
    }else if(direction == KDir.LEFT)
    {
      BR_L = new PVector(roadConnectionStart.x, roadConnectionStart.y + startWidth/2);
      BL_L = new PVector(roadConnectionStart.x - roadLength, roadConnectionStart.y + endWidth/2);
      TL_L = new PVector(roadConnectionStart.x - roadLength, roadConnectionStart.y - endWidth/2);
      TR_L = new PVector(roadConnectionStart.x, roadConnectionStart.y - startWidth/2);
    }else
      println("ERROR: No valid direction value found in StraightRoad Constructer");
  }
  
  public boolean contains(PVector p)
  {
    PVector TR, TL, BR, BL;
    
    switch(direction)
    {
      case UP:
      {
        TR = TR_UP;
        TL = TL_UP;
        BR = BR_UP;
        BL = BL_UP;
        break;
      }
      case RIGHT:
      {
        TR = TR_R;
        TL = TL_R;
        BR = BR_R;
        BL = BL_R;
        break;
      }
      case LEFT:
      {
        TR = TR_L;
        TL = TL_L;
        BR = BR_L;
        BL = BL_L;
        break;
      }
      default:
      {
        println("ERROR: Default case called for switch in StraightRoad.contains()");
        return false;
      }
    } // End Switch
    
    LineEqn top = new LineEqn(TR, TL);
    LineEqn bottom = new LineEqn(BR, BL);
    LineEqn right = new LineEqn(TR, BR);
    LineEqn left = new LineEqn(TL, BL);
    
    if(top.above(p) || !bottom.above(p) || !left.above(p) || right.above(p))
      return false;
    
    return true;
  }
  
  public PVector getRoadConnectionEnd()
  {
    switch(direction)
    {
      case UP:
        return new PVector(roadConnectionStart.x, roadConnectionStart.y - roadLength);
      case RIGHT:
        return new PVector(roadConnectionStart.x + roadLength, roadConnectionStart.y);
      case LEFT:
        return new PVector(roadConnectionStart.x - roadLength, roadConnectionStart.y);
      default:
        println("ERROR: Default case for switch called in StraightRoad.getRoadConnection()");
        return null;
    } // End Switch
  }
  
  public float getScreenHeight()
  {
    if(direction == KDir.UP)
      return roadLength;
    else
    {
      if(endWidth > startWidth)
        return endWidth - startWidth;
    }
    
    return 0;
  }
  
  public float getTrackLenght()
  {
    return roadLength;
  }
  
  public float getEndWidth()
  {
    return endWidth;
  }
  public void render(int yOffset)
  {
    if(yOffset < 0)
    {
      println("Negative yOffset in StraightRoad.render(int)");
      return;
    }
    
    s = createShape();
    s.beginShape();
    s.fill(colour);
    
    switch(direction)
    {
      case UP:
      {
        s.vertex(BL_UP.x, BL_UP.y);
        s.vertex(BR_UP.x, BR_UP.y);
        s.vertex(TR_UP.x, TR_UP.y);
        s.vertex(TL_UP.x, TL_UP.y);
        break;
      }
      case RIGHT:
      {
        s.vertex(TL_R.x, TL_R.y);
        s.vertex(BL_R.x, BL_R.y);
        s.vertex(BR_R.x, BR_R.y);
        s.vertex(TR_R.x, TR_R.y);
        break;
      }
      case LEFT:
      {
        s.vertex(TR_L.x, TR_L.y);
        s.vertex(BR_L.x, BR_L.y);
        s.vertex(BL_L.x, BL_L.y);
        s.vertex(TL_L.x, TL_L.y);
        break;
      }
      default:
        println("ERROR: Default case for switch called in StraightRoad.getEndWidth()");
        return;
    } // End Switch
    
    s.endShape(CLOSE);
    shape(s, 0, yOffset);
    
  } // End render()
  
  public boolean belowScreen(int yOffset)
  {
    switch(direction)
    {
      case UP:
      {
        if((roadConnectionStart.y - roadLength + yOffset) > height)
          return true;
          
        return false;
      }
      case LEFT:
      case RIGHT:
      {
        float roadWidth = (endWidth > startWidth) ? endWidth : startWidth;
        
        if((roadConnectionStart.y + roadWidth/2 + yOffset) > height)
          return true;
          
        return false;
      }
    }
    
    return true;
  }
  
  public KDir getDirection()
  {
    return direction;
  }
  
} // End StraightRoad