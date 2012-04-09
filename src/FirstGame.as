package
{
	import org.flixel.FlxGame;
	[SWF(width = "960", height = "720", backgroundColor = "#000000")]

	public class FirstGame extends FlxGame
	{
		public function FirstGame()
		{
			super(320, 240, MenuState, 3);
			forceDebugger = true;
		}
	}
}