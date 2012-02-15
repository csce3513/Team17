package
{
	import org.flixel.*;
	import flash.system.*;

	public class MenuState extends FlxState
	{
		private var startButton:FlxButton;
		private var quitButton:FlxButton;

		public function MenuState()
		{
		}

		override public function create():void
		{
			FlxG.mouse.show();
			startButton = new FlxButton(120, 100, "Start Game", startGame);
			add(startButton);
			
			quitButton = new FlxButton(120, 160, "Quit Game", quitGame);
			add(quitButton);
		}

		private function startGame():void
		{
			FlxG.mouse.hide();
			FlxG.switchState(new PlayState);
		}
		
		private function quitGame():void {
			FlxG.mouse.hide();
			fscommand("quit");
		}
	}
}