package  
{
	/**
	 * ...
	 * @author David Knapp
	 */
	import org.flixel.*;
	public class Enemy extends FlxSprite
	{
		[Embed(source = "../assets/stickmanTestImage15-24.png")] private var stickmanGraphic:Class;
		private var maxHealth:Number; //include in the constructor?
		public function Enemy(X:Number = 10, Y:Number = 10):void
		{
			super(X, Y);
			loadGraphic(stickmanGraphic, true, true, 15, 24);
			maxHealth = 5;
			health = 5; // setters
			solid = true;
			moves = true;
			immovable = true;
		}
		
		public function getHealth():Number {
			return health;
		}
		
		public function doDamage(damage:Number):void {
			health -= damage;
			if (health < 1) die();
		}
		
		public function die():void {
			kill();
		}
		
		public function heal(heal:Number):void {
			health += heal;
			if (health > maxHealth) health = maxHealth;
		}
		
	}

}