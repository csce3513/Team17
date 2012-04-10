package  
{
	/**
	 * ...
	 * @author David Knapp
	 */
	import org.flixel.*;
	public class Enemy extends FlxSprite
	{
		[Embed(source = "../assets/spike.png")] private var spikeGraphic:Class;
		private var maxHealth:Number; //include in the constructor?
		public var attackTimer:FlxTimer = new FlxTimer;
		public var patroller:Boolean;
		public var ePath:FlxPath = new FlxPath();
		public function Enemy(X:Number, Y:Number, pathStartX:Number = 0, pathStartY:Number = 0, pathEndX:Number = 0, pathEndY:Number = 0, p:Boolean = false):void
		{
			super(X, Y);
			loadGraphic(spikeGraphic, true, true, 30, 24);
			ePath.addAt(pathStartX, pathStartY, 0);
			ePath.addAt(pathEndX, pathEndY, 1);
			patroller = p;
			if (patroller)	followPath(ePath, 25, PATH_LOOP_FORWARD, false);
			maxHealth = 5;
			health = 5; // setters
			solid = true;
			moves = true;
			immovable = true;
			attackTimer.start(.01, 1);
			width = 10;
			height = 18;
			offset.x = 8;
			//offset.y = 2;

		}
	
		public function doDamage(damage:Number):void {
			health -= damage;
			flicker(.25);
			if (health < 1) kill();
		}
		
		public function heal(heal:Number):void {
			health += heal;
			if (health > maxHealth) health = maxHealth;
		}
		
		public function attack(p:Player):void {
			//stopFollowingPath();
			if (alive && !p.isInvulnerable) p.doDamage(1);
			//followPath(ePath, 25, PATH_LOOP_BACKWARD, false);
		}
		
		public function getMeleeAttackZone():FlxRect {
			var attackBox:FlxRect;
			var currentCoords:FlxPoint = new FlxPoint();
			currentCoords = getScreenXY();
			attackBox = new FlxRect(currentCoords.x , currentCoords.y - 1, 30, 5);
			return attackBox;
		}
		
		public function getHitBox():FlxRect {
			var coords:FlxPoint = getScreenXY();
			var hitbox:FlxRect = new FlxRect(coords.x , coords.y, width, height);
			return hitbox;
		}		
		
		public function justAttacked():void {
			attackTimer.start(2, 1);
		}
	}

}