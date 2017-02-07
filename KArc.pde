class KArc extends RoadComponent
{
  KArcType type;
  PVector origin;
  float radius;
    
  public KArc(PVector _roadConnectionStart, float _startWidth, KArcType _type)
  { 
    super(_roadConnectionStart, _startWidth, (_type == KArcType.L) ? KDir.LEFT : ( (_type == KArcType.R) ? KDir.RIGHT : KDir.UP));
    
    type = _type;
    radius = _startWidth;
    
    switch(type)
    {
      case R:
      {
        origin = new PVector(roadConnectionStart.x + (radius / 2), roadConnectionStart.y);
        break;
      }
      case L:
      {
        origin = new PVector(roadConnectionStart.x - (radius / 2), roadConnectionStart.y);
        break;
      }
      case UFR:
      case UFL:
      {
        origin = new PVector(roadConnectionStart.x, roadConnectionStart.y - (radius / 2));
        break;
      }
      default:
        println("ERROR: Default switch value called in KArc Constructor");
        return;
    }
  } // End KArc()
  
  public PVector getRoadConnectionEnd()
  {
    switch(type)
    {
      case R:
        return new PVector(roadConnectionStart.x + (radius / 2), roadConnectionStart.y - (radius / 2));
      case L:
        return new PVector(roadConnectionStart.x - (radius / 2), roadConnectionStart.y - (radius / 2));
      case UFR:
        return new PVector(roadConnectionStart.x + (radius / 2), roadConnectionStart.y - (radius / 2));
      case UFL:
        return new PVector(roadConnectionStart.x - (radius / 2), roadConnectionStart.y - (radius / 2));
      default:
        println("ERROR: Default switch value called for KArc.getRoadConnectionEnd()");
        return null;
    }
  }
  
  public boolean inHorizonRange(int offset)
  {
    
    //println("Testing ARC (Start X: " + roadConnectionStart.x + ", radius: " + radius + ", Offset*3: " + offset*3 + ", width: " + width + ")");
    //println("Direction: " + type);
    switch(type)
    {
      case R:
      {
        if((roadConnectionStart.x + radius) < (width - offset*2))
        {
          return true;
        }
        else
        {
          println("Rejecting Right bound Corner");
          return false;
        }
      }
      case L:
      {
        if((roadConnectionStart.x - radius) > (offset*2))
          return true;
        else 
        {
          println("Rejecting Left bound Corner");
          return false;
        }
      }
      default:
      {
        return true;
      }
    }
  }
  
  public float getScreenHeight()
  {
    if(type == KArcType.R || type == KArcType.L)
      return radius;
    else
      return 0;
  }
  
  public float getTrackLenght()
  {
    // 2rPI = circumference of a circ
    // We assume the driver will drive in the middle of the track, thus we use have the radius in our calculation (2r becomes r)
    // We also only want 1/4 of the circumference of a full circle (Divide all by 4)
    return ((radius)*PI)/4;
  }
  
  public float getEndWidth()
  {
    return startWidth;
  }
  
  public void render(int yOffset)
  {
    strokeWeight(0);
    fill(colour);
    
    switch(type)
    {
      case R:
        arc(origin.x, origin.y + yOffset, radius*2, radius*2, radians(180), radians(270), PIE);
        break;
      case L:
        arc(origin.x, origin.y + yOffset, radius*2, radius*2, radians(270), radians(360), PIE);
        break;
      case UFR:
        arc(origin.x, origin.y + yOffset, radius*2, radius*2, radians(0), radians(90), PIE);
        break;
      case UFL:
        arc(origin.x, origin.y + yOffset, radius*2, radius*2, radians(90), radians(180), PIE);
        break;
      default:
        println("ERROR: Default switch case called in KArc.render()");
        return;
    }
  } // End render()
  
  public boolean contains(PVector p)
  {
    
    if(dist(origin.x, origin.y, p.x, p.y) > radius)
      return false;
    
    switch(type)
    {
      case R:
      {
        if(p.x >= origin.x - radius && p.x <= origin.x && p.y <= origin.y && p.y >= origin.y - radius)
          return true;
        
        return false;
      }
      case L:
      {
        if(p.x >= origin.x && p.x <= origin.x + radius && p.y <= origin.y && p.y >= origin.y - radius)
          return true;
          
        return false;
      }
      case UFR:
      {
        if(p.x >= origin.x && p.x <= origin.x + radius && p.y >= origin.y && p.y <= origin.y + radius)
          return true;
          
        return false;
      }
      case UFL:
      {
        if(p.x >= origin.x - radius && p.x <= origin.x && p.y >= origin.y && p.y <= origin.y + radius) 
          return true;
          
        return false;
      }
      default:
      {
        println("ERROR: Default switch case called in KArc");
        return false;
      }
    } // End Switch
  } // End contains()
  
  public boolean belowScreen(int yOffset)
  {
    //println("Checking whether Arc is below the screen");
    switch(type)
    {
      case L:
      case R:
      {
        if((getRoadConnectionEnd().y + yOffset + radius/2) > height)
        {
          //println("Arc below screen");
          return true;
        }
        return false;
      }
      case UFR:
      case UFL:
      {
        if((getRoadConnectionEnd().y + yOffset) > height)
        {
          //println("Arc below screen");
          return true;
        } 
        return false;
      }
      default:
      {
        println("Default case called in KArc.belowScreen()");
        return true;
      }
    }
  }
  
  public KDir getDirection()
  {
    return direction;
  }
  
} // End KArc