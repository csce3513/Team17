package
{
	import org.flixel.*;

	public class MenuState extends FlxState
	{
		private var startButton:FlxButton;
		public var instructions:FlxText;

		public function MenuState()
		{
		}

		override public function create():void
		{
			[Embed(source = "../assets/Pirate_titlescreen.png")] var ImgBackdrop:Class;
			var _GroundBackdrop:Backdrop = new Backdrop( 0, 0, ImgBackdrop, .3);
			add(_GroundBackdrop);
			instructions = new FlxText(80, 90, 200, "Press Space to jump and C to attack!");
			instructions.color = 0x00000000;
			add(instructions);
			FlxG.mouse.show();
			startButton = new FlxButton(120, 110, "Start Game", startGame);
			add(startButton);
		}

		private function startGame():void
		{
			FlxG.mouse.hide();
			FlxG.switchState(new PlayStateLevelOne);
		}
	}
}