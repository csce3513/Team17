package
{
	import org.flixel.*;

	public class MenuState extends FlxState
	{
		private var startButton:FlxButton;

		public function MenuState()
		{
		}

		override public function create():void
		{
			[Embed(source = "../assets/Pirate_titlescreen.png")] var ImgBackdrop:Class;
			var _GroundBackdrop:Backdrop = new Backdrop( 0, 0, ImgBackdrop, .3);
			add(_GroundBackdrop);
			FlxG.mouse.show();
			startButton = new FlxButton(120, 110, "Start Game", startGame);
			add(startButton);
		}

		private function startGame():void
		{
			FlxG.mouse.hide();
			FlxG.switchState(new StoryState);
		}
	}
}