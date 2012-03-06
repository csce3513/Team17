package  
{	
	 
	public class Player
	{
		private var playerHealth:Number;
		public function Player() 
		{
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