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
		private var maxHealth:Number; //include in the constructor?
		public var attackTimer:FlxTimer = new FlxTimer;
		public var attackDelay:FlxTimer = new FlxTimer;
		public var ePath:FlxPath = new FlxPath();
		public var lastAnim:String = new String;
		public function Enemy(X:Number, Y:Number, pathStartX:Number = 0, pathStartY:Number = 0, pathEndX:Number = 0, pathEndY:Number = 0):void
		{
			super(X, Y);
			loadGraphic(spikeGraphic, true, true, 30, 24);
			ePath.addAt(pathStartX, pathStartY, 0);
			ePath.addAt(pathEndX, pathEndY, 1);
			maxHealth = 5;
			health = 5; // setters
			solid = true;
			moves = true;
			immovable = true;
			attackTimer.start(.01, 1);
			attackDelay.start(.01, 1);
			width = 10;
			height = 18;
			offset.x = 8;
			
			addAnimation("walk", [2, 1, 2, 0], 12, true);
			addAnimation("attack", [3,4,5], 12, true);
			//offset.y = 2;
			
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
			if (alive) {
				stopFollowingPath();
				p.doDamage(1);
				play("attack");
				lastAnim = "attack";
			}
		}
		
		public function getMeleeAttackZone():FlxRect {
			var attackBox:FlxRect;
			var currentCoords:FlxPoint = new FlxPoint();
			currentCoords = getScreenXY();
			attackBox = new FlxRect(currentCoords.x , currentCoords.y, 25, 5);
			return attackBox;
		}
		
		public function getHitBox():FlxRect {
			var coords:FlxPoint = getScreenXY();
			var hitbox:FlxRect = new FlxRect(coords.x , coords.y, width-6, height);
			return hitbox;
		}		
		
		public function justAttacked():void {
			attackDelay.start(2, 1);
			attackTimer.start(.25, 1);
		}
	}

}