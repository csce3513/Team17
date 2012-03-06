package  
{
	/**
	 * ...
	 * @author David Knapp
	 */
	import org.flixel.*;
	public class Enemy extends FlxSprite
	{
		[Embed(source = "../assets/enemyStickman.png")] private var stickmanGraphic:Class;
		public function Enemy():void
		{
			super(55, 55); //spawns at 180,40
			loadGraphic(stickmanGraphic, false, 18, 24);
			setHealth(1); // setters
			solid = true;
			moves = false;
			immovable = true;
		}
		
		private function setHealth(damage:Number):void {
			health = health - damage;
		}
		
		private function getHealth():Number {
			return health;
		}
		
		public function takeDamage(damage:Number):void {
			setHealth(damage);
		}
		
	}

}