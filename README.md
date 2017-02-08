<h2>Tracker!</h2>

<h4>What is tracker?</h4>
<p>
Tracker is a game that simply involves keeping a round game object on the track at all times. You steer the 'ball' with your mouse and if the ball goes off the track then you lose the game. Otherwise the game will go on indefinetly and the program will store the overall length of all the track that has been generated while you've been playing. The cool thing about this game I think is the track generation, to which the rest of the game was mostly built around. The track generates itself using 3 different types of straight road segments and 4 different types of corner road segments. The world generation is smart enough to generate varied road content that doesn't go off the screen or otherwise make it impossible to travel along. 
</p>
<p>
All of these road segment types inherit from an abstract class called RoadComponents. This class has the following exposed methods that are quite helpful when dealing with different types of road segments.
</p>

	public abstract KDir getDirection();
  	public abstract PVector getRoadConnectionEnd();
  	public abstract boolean contains(PVector p);
  	public abstract float getScreenHeight();
  	public abstract float getTrackLenght();
  	public abstract float getEndWidth();
  	public abstract void render(int yOffset); 
  	public abstract boolean inHorizonRange(int offset);
  	public abstract boolean belowScreen(int yOffset);

<h4>Controls / How to play</h4>

Playing tracker is very easy since the game itself is quite simple! At the start screen simply press *p* to start the game. Once the game is started you will see the track has been generated for you. The ball will move itself without any prompting, all you have to do is move to mouse in the direction that you will the ball to go. The ball will move towards the mouse at whatever speed it is set to. Although you don't have to manage speed in the game, if you wish to go slower or faster you can use the *w* and *s* keys to speed up and slow down the speed of the ball respectably. The is a limit to how slow and fast the ball can move at. If you wish to quit the game at any point just press *q*. That's all there is to it, after you move off the track the end game screen will display telling you how much track you managed to generate on your journey!

<h5>Summery of Controls</h5>
Start Game: p key
Steer : Using mouse
Increase Speed: w key
Decrease Speed: s key
Quit: q key