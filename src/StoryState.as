package
{
	import org.flixel.*;

	public class StoryState extends FlxState
	{
		public var instructions:FlxText;

		public function StoryState()
		{
		}

		override public function create():void
		{
			[Embed(source = "../assets/Pirate_titlescreen.png")] var ImgBackdrop:Class;
			var _GroundBackdrop:Backdrop = new Backdrop( 0, 0, ImgBackdrop, .3);
			add(_GroundBackdrop);
			instructions = new FlxText(65, 90, 200, "While searching for loot in your flying pirate ship, a sudden gust caught you off guard and crashed your ship on a mystical and dangerous island. Landing in the forest you set out to retrieve parts of the ship, only to find monsters of all kinds! Using the arrow keys to move, space to jump, and 'C' to wield your sword on your bloodthirsty enemies, defeat them to retrieve your gears and reveal the path to escape! Press Space to start.");
			instructions.color = 0x00000000;
			add(instructions);
		}
		
		override public function update():void
		{
			if (FlxG.keys.justPressed("SPACE")) {
				startGame();
			}
		}

		private function startGame():void
		{
			FlxG.switchState(new PlayStateLevelOne);
		}
	}
}