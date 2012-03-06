package  
{	
	import org.flixel.*; 
	public class Player extends FlxSprite
	{
		private var playerHealth:Number;
		public function Player(X:Number=0,Y:Number=0,SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
			playerHealth = 10;
		}
		
		//Basic function to do damage to the player.
		public function doDamage(damage:Number):void{
			playerHealth = playerHealth - damage;
		}
		
		//Basic function to give health back to the player
		public function heal(heal:Number):void{
			playerHealth = playerHealth + heal;
		}
		
		public function getHealth():Number {
			return playerHealth;
		}
	}

}