package  
{

	import org.flixel.*;
	public class victoryState extends FlxState
	{
		
		public function victoryState() 
		{
		}
		private var victoryText:FlxText;
		override public function create():void
		{
			victoryText = new FlxText(60, 75, 200, "Congrations, you found all of the pieces of the ship and won the game! Press the spacebar to return to the title screen.");
			victoryText.color = 0xff000000;
			add(victoryText);
			
			//[Embed(source = "../assets/VictoryScreenPlaceholderSmall.png")] var ImgBackdrop:Class;
			//var _GroundBackdrop:Backdrop = new Backdrop( 0, 0, ImgBackdrop, 0); //was using this to have placeholder art, but a textbox works best in lieu of art
			//add(_GroundBackdrop);
		}
		
		override public function update():void
		{
			if (FlxG.keys.justPressed("SPACE")) {
				startGame();
			}
		}

		private function startGame():void
		{
			FlxG.switchState(new MenuState);
		}
	}

}