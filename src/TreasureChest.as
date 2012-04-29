package  
{
	/**
	 * ...
	 * @author David Knapp
	 */
	
	import org.flixel.*;
	public class TreasureChest extends FlxSprite
	{
		[Embed(source = '../assets/gear.png')] private var gearGraphic:Class;
		// all of these initial variable assignments will be changed to parameters passed from the level loading methods.
		public function TreasureChest(x:Number, y:Number):void {  
			super(x, y); //spawns at 180,40
			loadGraphic(gearGraphic, true, false, 23, 23, true);
			addAnimation("Spin", [0, 1], 12);
			play("Spin");
			solid = false;
			moves = false;
			immovable = true;
		}
	}

}