package  
{
	import org.flixel.*;
	public class Boomeranger extends FlxSprite
	{
		[Embed(source = "../assets/boomeranger.png")] private var boomerangerGraphic:Class;
		public var startingX:Number;
		public var startingY:Number;
		public var attackDelay:FlxTimer = new FlxTimer;
		public var attackTimer:FlxTimer = new FlxTimer;
		private var ePath:FlxPath = new FlxPath();
		private var lastAnim:String = new String;
		public var type:String = "boomeranger";
		private var boomerang:Boomerang;
		public var hasActiveBoomerang:Boolean = false;
		private var boomerangPath:FlxPath = new FlxPath();
		public var boomerangTimer:FlxTimer = new FlxTimer();
		public function Boomeranger(X:Number, Y:Number, pathStartX:Number = 0, pathStartY:Number = 0, pathEndX:Number = 0, pathEndY:Number = 0):void
		{
			super(X, Y);
			startingX = X;
			startingY = Y;
			
			loadGraphic(boomerangerGraphic, true, true, 24, 24);
			
			ePath.addAt(pathStartX, pathStartY, 0);
			ePath.addAt(pathEndX, pathEndY, 1);
			
			health = 3; // setters
			solid = true;
			moves = false;
			immovable = true;
			
			attackDelay.start(.01, 1);
			attackTimer.start(.01, 1);
			
			width = 10;
			height = 18;
			offset.x = 0;
			offset.y = 4;
			facing = RIGHT;
			
			addAnimation("Throw", [2, 1], 4, false);
			addAnimation("Idle", [0], 0, false);
			//addAnimation("walk", [2, 1, 2, 0], 12, true);
			//addAnimation("attack", [3,4,5], 12, true);
			
			if (pathStartX != pathEndX) {
				followPath(ePath, 8, PATH_LOOP_FORWARD, false);
				//play("walk");
				//lastAnim = "walk";
			}
		}
	
		override public function update():void {
			if (attackTimer.finished)
				play("Idle");
		}
		
		public function faceLeft():void {
		facing = LEFT;	
		}
		
		public function faceRight():void {
		facing = RIGHT;	
		}
		
		public function doDamage(damage:Number):void {
			health -= damage;
			flicker(.25);
			if (health < 1) kill();
		}
		
		public function throwBoomerang(_x:Number, _y:Number):Boomerang { //throws a boomerang, _x, _y are the thrower's coordinates
			play("Throw");
			if (facing == LEFT) {
				boomerang = new Boomerang(_x - 11, _y +7);
				boomerangPath.addAt(_x - 11, _y + 7, 0);
				boomerangPath.addAt(_x - 61, _y + 7, 1);
				boomerangPath.addAt(_x - 11, _y + 7, 2);
			} else {
				boomerang = new Boomerang(_x + 31, _y + 7);
				boomerangPath.addAt(_x + 31, _y + 7, 0);
				boomerangPath.addAt(_x + 81, _y + 7, 1);
				boomerangPath.addAt(_x + 31, _y + 7, 2);
			}
			attackTimer.start(.5);
			hasActiveBoomerang = true;
			boomerang.followPath(boomerangPath, 90);
			boomerangTimer.start(1.1, 1);
			attackDelay.start(2.5, 1);
			return boomerang;
		}
		
		public function checkBoomerangCollisions(p:Player):void { // to be called in update()
			if (boomerang.alive && boomerang.overlaps(p)) {
				p.doDamage(1);
			}
		}
		
		public function resetBoomerang():void {
			boomerang.kill();
			hasActiveBoomerang = false;
		}
		
		//check to see if player is in throwing range.  throw boomerang.
		//public function tryAttack(p:Player):Boolean {
			//if (alive && attackDelay.finished && getAttackZone().overlaps(p.getHitBox())) {
				//if (facing == LEFT) {
					//throwBoomerang(startingX + 11, startingY + 7);
				//} else {
					//throwBoomerang(startingX + 31, startingY + 7);
				//}
				//tempPlayer = p;
				//play("attack");    //add a sprite to throw a boomerang
				//lastAnim = "attack";
				//return true;
			//}
			//return false;
		//}
		
		public function getAttackZone():FlxRect {
			var attackZone:FlxRect;
			var currentCoords:FlxPoint = getScreenXY();
			if (facing == LEFT)
				attackZone = new FlxRect(currentCoords.x-201, currentCoords.y, 200, height);
			else
				attackZone = new FlxRect(currentCoords.x+width+1, currentCoords.y, 200, height);
			return attackZone;
		}
		
		public function getHitBox():FlxRect {
			var coords:FlxPoint = getScreenXY();
			var hitbox:FlxRect = new FlxRect(coords.x , coords.y, width, height);
			return hitbox;
		}	
	}
}