package  
{	
	import flash.utils.Timer;
	import org.flixel.*; 
	public class Player extends FlxSprite
	{
		[Embed(source = '../assets/pirate_sheet.png')] private var piratePNG:Class;
		
		private var maxHealth:Number = 10;
		private var startingX:Number;
		private var startingY:Number;
		public var lives:Number = 3;
		public var isInvulnerable:Boolean = false;
		public var invulnerableTimer:FlxTimer = new FlxTimer();
		public function Player(X:Number=0,Y:Number=0) 
		{
			startingX = X;
			startingY = Y;
			super(X, Y);
			loadGraphic(piratePNG, true, true, 24, 24, true);
			addAnimation("walk", [0, 1, 0, 2], 10, true);
			addAnimation("idle", [0], 0, false);
			addAnimation("jump", [3], 0, false);
			width = 20;
			height = 20;
			offset.x = 2;
			offset.y = 2;
			maxVelocity.x = 80;
			maxVelocity.y = 200;
			acceleration.y =  200;
			drag.x = maxVelocity.x * 4;
			health = maxHealth;
		}
		override public function update():void
		{
		super.update();
		acceleration.x = 0;

		if (invulnerableTimer.finished) setVulnerable();
		
		if (FlxG.keys.justPressed("SPACE") && this.isTouching(FlxObject.FLOOR))
		{
			velocity.y = -maxVelocity.y / 1.5;
		}
		
		//Plays jump animation during jumping and falling
		if (velocity.y != 0)
		play("jump");
		
		if (FlxG.keys.LEFT)
		{
			acceleration.x -= drag.x;
			//acceleration.x = -maxVelocity.x * 4;
			facing = FlxObject.LEFT;
			if(velocity.y == 0)//prevents overiding the jump animation
			play("walk");
		}
		if (FlxG.keys.RIGHT)
		{
			//acceleration.x = maxVelocity.x * 4;
			acceleration.x += drag.x;
			facing = FlxObject.RIGHT;
			if(velocity.y == 0)
			play("walk");
		}
		//resets pose back to idle on rest
		if (this.acceleration.x == 0 && this.velocity.y == 0)
			play("idle");
		}

		//Basic function to do damage to the player.
		public function doDamage(damage:Number):void{
			health -= damage;
			if (health < 1) die();
			setInvulnerable();
			flicker(2);
		}
	
		//Basic function to give health back to the player
		public function heal(heal:Number):void {
			health += heal;
			if (health > maxHealth) health = maxHealth;
		}
		
		public function getMaxHealth():Number {
			return maxHealth;
		}
		
		public function die():void {
			lives -= 1;
			if (lives < 0) FlxG.shake(0.1, .5, FlxG.resetGame, false, 0); 
			else  {
				FlxG.shake(0.1, .5, null, false, 0);
				this.reset(startingX, startingY);
				health = maxHealth;
			}
			
			// add a custom level reset function call instead of resetState.
			// reset player location and decrement lives, reset enemy ststes and respawn, respawn world object.
			
			
		}
		
		public function setInvulnerable():void {
			isInvulnerable = true;
			invulnerableTimer = new FlxTimer();
			invulnerableTimer.start(2, 1);
		}
		
		public function setVulnerable():void {
			isInvulnerable = false;
		}
		
		public function getHitBox():FlxRect {
			var coords:FlxPoint = getScreenXY();
			var hitbox:FlxRect = new FlxRect(coords.x , coords.y, width, height);
			return hitbox;
		}
		
		public function getMeleeAttackZone():FlxRect {
			var attackBox:FlxRect;
			var currentCoords:FlxPoint = new FlxPoint();
			currentCoords = getScreenXY();
			attackBox = new FlxRect(currentCoords.x - 16, currentCoords.y + 12, 64, 5);
			return attackBox;
		}
		
		public function attack(e:Enemy):void {
			if (getMeleeAttackZone().overlaps(e.getHitBox()))
				e.doDamage(1);
		}
	}

}