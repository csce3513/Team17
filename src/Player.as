package  
{	
	import flash.utils.Timer;
	import org.flixel.*; 
	public class Player extends FlxSprite
	{
		[Embed(source = '../assets/Pirate30x24.png')] private var piratePNG:Class;
		
		private var maxHealth:Number = 10;
		public var attackDelay:FlxTimer = new FlxTimer();
		public var startingX:Number;
		public var startingY:Number;
		public var lives:Number = 3;
		public var isInvulnerable:Boolean = false;
		public var invulnerableTimer:FlxTimer = new FlxTimer();

		public function Player(X:Number=0,Y:Number=0) 
		{
			startingX = X;
			startingY = Y;
			super(X, Y);
			loadGraphic(piratePNG, true, true, 30, 24, true);
			addAnimation("walk", [0, 1, 0, 2], 12, true);
			addAnimation("idle", [0], 0, false);
			addAnimation("jump", [3], 0, false);
			addAnimation("fall", [4], 0, false);
			addAnimation("slash1", [5,6,7], 10, true);
			invulnerableTimer.start(.1, 1);
			width = 20;
			height = 20;
			offset.x = 2;
			offset.y = 4;
			maxVelocity.x = 100;
			maxVelocity.y = 220;
			acceleration.y =  200;
			drag.x = maxVelocity.x * 4;
			health = maxHealth;
			attackDelay.start(.1, 1);
		}
		override public function update():void
		{
			super.update();
			acceleration.x = 0;

			if (invulnerableTimer.finished) setInvulnerable(false);
			
			if (FlxG.keys.justPressed("SPACE") && this.isTouching(FlxObject.FLOOR))
			{
				velocity.y = -maxVelocity.y / 1.5;
			}
		
			
			//Plays jump animation during jumping and falling
			if (velocity.y < 0 && attackDelay.finished)
				play("jump");
			if (velocity.y > 0 && attackDelay.finished)
				play("fall");
			
			if (FlxG.keys.LEFT)
			{
				acceleration.x -= drag.x;
				facing = FlxObject.LEFT;
				if(velocity.y == 0 && attackDelay.finished)//prevents overiding the jump animation
				play("walk");
			}
			if (FlxG.keys.RIGHT)
			{
				acceleration.x += drag.x;
				facing = FlxObject.RIGHT;
				if(velocity.y == 0 && attackDelay.finished)
				play("walk");
			}
			
			//resets pose back to idle on rest
			if (this.acceleration.x == 0 && this.velocity.y == 0 && attackDelay.finished)
				play("idle");
		}

		//Basic function to do damage to the player.
		public function doDamage(damage:Number):void{
			if (!isInvulnerable) {
				health -= damage;
				reactToAttack();
				if (health < 1) die();
			}
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
		
		public function setInvulnerable(inv:Boolean = true):void {
			if (inv == true)
			{
			isInvulnerable = true;
				if (invulnerableTimer.finished) {
					invulnerableTimer.start(1, 1);
					flicker(1);
				}
			}
			else
			isInvulnerable = false;
		}
		
		public function getHitBox():FlxRect {
			var hitbox:FlxRect;
			var coords:FlxPoint = getScreenXY();
			if (facing == LEFT)	hitbox = new FlxRect(coords.x + 6, coords.y, 24, 24);
			else hitbox = new FlxRect(coords.x, coords.y, 24, 24);
			return hitbox;
		}
		
		public function getMeleeAttackZone():FlxRect {
			var attackBox:FlxRect;
			var currentCoords:FlxPoint = new FlxPoint();
			currentCoords = getScreenXY();
			if (facing == LEFT)
				attackBox = new FlxRect(currentCoords.x-15, currentCoords.y + 8, 20, height / 2);
			else
				attackBox = new FlxRect(currentCoords.x+18, currentCoords.y + 8, 10, height/2);
			return attackBox;
		}
		
		public function attackSpike(e:Enemy):void {
			if (getMeleeAttackZone().overlaps(e.getHitBox()))
				e.doDamage(1);
		}
		
		public function attackBoomeranger(b:Boomeranger):void {
			if (getMeleeAttackZone().overlaps(b.getHitBox()))
				b.doDamage(1);
		}
		
		public function reactToAttack():void {
			if (facing == LEFT) velocity.x = 150; else velocity.x = -150;
			setInvulnerable();
		}
	}

}