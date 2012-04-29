package  
{
	import org.flixel.FlxPath;
	/**
	 * ...
	 * @author David Knapp
	 */
	
	 import org.flixel.*;
	 
	public class Boomerang extends FlxSprite
	{

		
		public function Boomerang(_x:Number, _y:Number):void
		{
			super(_x, _y);
			makeGraphic(10, 10, 0xff663300); //will add sprite for this later, brown box for now
			solid = false;
		}
		
	}

}