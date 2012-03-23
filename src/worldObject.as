package  
{
	/**
	 * ...
	 * @author David Knapp
	 */
	
	import org.flixel.*;
	public class worldObject extends FlxSprite
	{
		// all of these initial variable assignments will be changed to parameters passed from the level loading methods.
		public function worldObject():void {  
			super(250, 72); //spawns at 180,40
			makeGraphic(8, 8, 0xff000000); // 8x8 black object drawn at 140,80
			setHealth(1); // setters
			solid = true;
			moves = false;
			immovable = true;
		}

		//create without graphic
		//public function worldObject(W:Number, X:Number, Y:Number, HP:Number, T:String) 
		//{
			//super(X, Y);
			//makeGraphic(W, W, 0xff000000);
			//setHealth(1);
			//acceleration.y = 0;
			//maxVelocity.x = 0;
			//maxVelocity.y = 0;
		//}

		//create with graphic (for later)
		//public function worldObject(Graphic:Class, Width:Number, X:Number, Y:Number, hp:Number, type:String) 
		//{
			//loadGraphic(Graphic, X, Y, 0xFFFFFF, false);
			//this.health = hp;
		//}
		
		public function getHealth():Number {
			return health;	
		}
		public function setHealth(hp:Number):void {
			health = hp;
		}
	}

}