package  
{
	/**
	 * ...
	 * @author David Knapp
	 */
	import org.flixel.*;
	import org.flixel.system.FlxAnim;
	public class Enemy extends FlxSprite
	{
		[Embed(source = "../assets/spike.png")] private var spikeGraphic:Class;
		public var attackTimer:FlxTimer = new FlxTimer;
		public var startingX:Number;
		public var startingY:Number;
		public var attackDelay:FlxTimer = new FlxTimer;
		public var ePath:FlxPath = new FlxPath();
		public var lastAnim:String = new String;
		public var type:String = "spike";
		public function Enemy(X:Number, Y:Number, pathStartX:Number = 0, pathStartY:Number = 0, pathEndX:Number = 0, pathEndY:Number = 0):void
		{
			super(X, Y);
			startingX = X;
			startingY = Y;
			loadGraphic(spikeGraphic, true, true, 30, 24);
			ePath.addAt(pathStartX, pathStartY, 0);
			ePath.addAt(pathEndX, pathEndY, 1);
			health = 3; // setters
			solid = true;
			moves = true;
			immovable = true;
			attackTimer.start(.01, 1);
			attackDelay.start(.01, 1);
			width = 10;
			height = 18;
			offset.x = 0;
			
			addAnimation("walk", [2, 1, 2, 0], 12, true);
			addAnimation("attack", [3,4,5], 12, true);
			offset.y = 1;
			
			if (pathStartX != pathEndX) {
				followPath(ePath, 15, PATH_LOOP_FORWARD, false);
				play("walk");
				lastAnim = "walk";
			}
		}
	
		override public function update():void {
						
			if (attackTimer.finished == true && lastAnim == "attack")
			{
				play("walk");
				lastAnim = "walk";
				followPath(ePath, 25, PATH_LOOP_FORWARD, false);
			}
			
			if (velocity.x > 0) facing = RIGHT; else facing = LEFT;
		}
		
		public function doDamage(damage:Number):void {
			health -= damage;
			flicker(.25);
			if (health < 1) kill();
		}
		
		public function tryAttack(p:Player):Boolean {
			if (alive && getMeleeAttackZone().overlaps(p.getHitBox()) && attackDelay.finished) {
				stopFollowingPath();
				p.doDamage(1);
				play("attack");
				lastAnim = "attack";
				return true;
			}
			return false;
		}

		public function getMeleeAttackZone():FlxRect {
			var attackBox:FlxRect;
			var currentCoords:FlxPoint = getScreenXY();
			if (facing == LEFT)
				attackBox = new FlxRect(currentCoords.x, currentCoords.y - 1, 10, height);
			else
				attackBox = new FlxRect(currentCoords.x+24, currentCoords.y - 1, 10, height);
			return attackBox;
		}
		
		public function getHitBox():FlxRect {
			var coords:FlxPoint = getScreenXY();
			var hitbox:FlxRect;
			
			if (facing == RIGHT)
				hitbox = new FlxRect(coords.x , coords.y, width - 6, height);
			else
				hitbox = new FlxRect(coords.x + 6 , coords.y, width - 6, height);
				
			return hitbox;
		}		
		
		public function justAttacked():void {
			attackDelay.start(2, 1);
			attackTimer.start(.25, 1);
		}
	}

}