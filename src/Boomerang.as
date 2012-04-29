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
		[Embed(source = "../assets/boomerang.png")] private var boomerangGraphic:Class;
		
		public function Boomerang(_x:Number, _y:Number):void
		{
			super(_x, _y);
			loadGraphic(boomerangGraphic, true, false, 10, 10);
			addAnimation("spin", [0,1,2,3], 8, true);
			play("spin");
			solid = false;
		}
		
	}

}