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
			health = 1; // setters
			solid = true;
			moves = false;
			immovable = true;
		}
		
		public function getHealth():Number {
			return health;	
		}
		public function takeDamage(damage:Number):void {
			health = getHealth() - damage;
		}
	}

}