package  
{	
	import org.flixel.*; 
	public class Player extends FlxSprite
	{
		[Embed(source = '../assets/spritePirate.png')] private var piratePNG:Class;
		private var maxHealth:Number = 10;
		public function Player(X:Number=0,Y:Number=0) 
		{
			super(X, Y);
			loadGraphic(piratePNG,false, false, 20, 20);
			maxVelocity.x = 80;
			maxVelocity.y = 200;
			acceleration.y =  200;
			drag.x = maxVelocity.x * 4;
			health = 10;
		}
		
		//Basic function to do damage to the player.
		public function doDamage(damage:Number):void{
			health = getHealth() - damage;
			if (health < 1) die();
		}
		
		//Basic function to give health back to the player
		public function heal(heal:Number):void {
			health = getHealth() + heal;
			if (health > maxHealth) health = maxHealth;
		}
		
		public function getHealth():Number {
			return health;
		}
		
		public function die():void {
			 FlxG.shake(0.1, .5, FlxG.resetGame, false, 0);
		}
	}

}