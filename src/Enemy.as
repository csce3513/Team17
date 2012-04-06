package  
{
	/**
	 * ...
	 * @author David Knapp
	 */
	import org.flixel.*;
	public class Enemy extends FlxSprite
	{
		[Embed(source = "../assets/stickmanEnemy.png")] private var stickmanGraphic:Class;
		private var maxHealth:Number; //include in the constructor?
		public var ePath:FlxPath = new FlxPath();
		public function Enemy(X:Number, Y:Number, pathStartX:Number, pathStartY:Number, pathEndX:Number, pathEndY:Number):void
		{
			super(X, Y);
			loadGraphic(stickmanGraphic, true, true, 15, 24);
			ePath.addAt(pathStartX, pathStartY, 0);
			ePath.addAt(pathEndX, pathEndY, 1);
			this.followPath(ePath, 25, PATH_LOOP_FORWARD, false);
			maxHealth = 5;
			health = 5; // setters
			solid = true;
			moves = true;
			immovable = true;
		}
		
		public function doDamage(damage:Number):void {
			health -= damage;
			if (health < 1) die();
		}
		
		public function die():void {
			kill();
		}
		
		public function heal(heal:Number):void {
			health += heal;
			if (health > maxHealth) health = maxHealth;
		}
		
	}

}