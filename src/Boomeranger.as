package  
{
	/**
	 * ...
	 * @author David Knapp
	 */
	import org.flixel.*;
	import org.flixel.system.FlxAnim;
	public class Boomeranger extends FlxSprite
	{
		[Embed(source = "../assets/stickmanEnemy.png")] private var boomerangerGraphic:Class;
		private var maxHealth:Number; //include in the constructor?
		public var attackTimer:FlxTimer = new FlxTimer;
		public var startingX:Number;
		public var startingY:Number;
		public var attackDelay:FlxTimer = new FlxTimer;
		public var ePath:FlxPath = new FlxPath();
		public var lastAnim:String = new String;
		public var type:String = "boomeranger";
		public function Boomeranger(X:Number, Y:Number, pathStartX:Number = 0, pathStartY:Number = 0, pathEndX:Number = 0, pathEndY:Number = 0):void
		{
			super(X, Y);
			startingX = X;
			startingY = Y;
			
			loadGraphic(boomerangerGraphic, true, true, 15, 24);
			ePath.addAt(pathStartX, pathStartY, 0);
			ePath.addAt(pathEndX, pathEndY, 1);
			maxHealth = 3;
			health = maxHealth; // setters
			solid = true;
			moves = true;
			immovable = true;
			attackTimer.start(.01, 1);
			attackDelay.start(.01, 1);
			width = 10;
			height = 18;
			offset.x = 0;
			offset.y = 4;

			//addAnimation("walk", [2, 1, 2, 0], 12, true);
			//addAnimation("attack", [3,4,5], 12, true);
			
			if (pathStartX != pathEndX) {
				followPath(ePath, 8, PATH_LOOP_FORWARD, false);
				//play("walk");
				//lastAnim = "walk";
			}
		}
	
		override public function update():void {
						
			//if (attackTimer.finished == true && lastAnim == "attack")
			//{
				//play("walk");
				//lastAnim = "walk";
				//followPath(ePath, 25, PATH_LOOP_FORWARD, false);
			//}
			
			if (velocity.x > 0) facing = RIGHT; else facing = LEFT;
		}
		
		public function doDamage(damage:Number):void {
			health -= damage;
			flicker(.25);
			if (health < 1) kill();
		}
		
		//check to see if player is in throwing range.  throw boomerang.
		public function tryAttack(p:Player):Boolean {
			if (alive && attackDelay.finished) {
				//stopFollowingPath();
				p.doDamage(1);
				//play("attack");    //add a sprite to throw a boomerang
				//lastAnim = "attack";
				return true;
			}
			return false;
		}
		
		public function getAttackZone():FlxObject {
			var testObject:FlxObject;
			var currentCoords:FlxPoint = getScreenXY();
			if (facing == LEFT)
				testObject = new FlxObject(currentCoords.x, currentCoords.y, 200, height);
			else
				testObject = new FlxObject(currentCoords.x+width, currentCoords.y, 200, height);
			return testObject;
		}
		
		public function getHitBox():FlxRect {
			var coords:FlxPoint = getScreenXY();
			var hitbox:FlxRect = new FlxRect(coords.x , coords.y, width, height);
			return hitbox;
		}		
		
		public function justAttacked():void {
			attackDelay.start(2, 1);
			attackTimer.start(.25, 1);
		}
	}

}