package  
{
	/**
	 * ...
	 * @author David Knapp
	 */
	
	import org.flixel.*;
	public class TreasureChest extends FlxSprite
	{
		// all of these initial variable assignments will be changed to parameters passed from the level loading methods.
		public function TreasureChest(x:Number, y:Number):void {  
			super(x, y); //spawns at 180,40
			makeGraphic(16, 12, 0xffffff00);
			solid = false;
			moves = false;
			immovable = true;
		}
	}

}