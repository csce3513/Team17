package
{
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		public function PlayState()
		{
		}
		
		public var level:FlxTilemap;
		public var testEnemy:Enemy;
		public var player:Player;
		public var o:worldObject;
		private var paused:Boolean;
		public var pauseGroup:FlxGroup;
		private var quitBtn:FlxButton;
		private var cam:FlxCamera;
		private var vel:int;
		private var bar:FlxSprite;
		private var currentLevel:Number = 0;


		override public function create():void
		{
			FlxG.framerate = 30;
			FlxG.flashFramerate = 30;
			FlxG.bgColor = 0xffffffff;
			paused = false;
			pauseGroup = new FlxGroup();
			
			loadLevel(currentLevel);
			
			player = new Player(level.width / 2 - 8)
			add(player);
			
			drawHealthBar();
			
			o = new worldObject();
			add(o);
			
			testEnemy = new Enemy();
			add(testEnemy);
			
			cam = new FlxCamera(0, 0, FlxG.width, FlxG.height);
			cam.follow(player);
			cam.setBounds(0, 0, level.width, level.height);
			FlxG.addCamera(cam);
			
			quitBtn = new FlxButton(120, 120, "Quit", onQuit); //put the button out of screen so we don't see in the two other cameras
			pauseGroup.add(quitBtn);

			// Create a camera focused on the quit button.
			// We do this because we don't want the quit button to be
			// tinted by the other cameras.
		}
		override public function update():void 
		{
			FlxG.collide();
			
			player.acceleration.x = 0;
			bar.scale.x = player.getHealth() * 5;
			
			if (FlxG.keys.justPressed("P")) {
				FlxG.mouse.hide();
				paused = !paused;
			}
			
			if (paused) {
				FlxG.mouse.show();
				return pauseGroup.update();
			}
			
			if (FlxG.keys.justPressed("H")) {
				player.doDamage(1);
				//bar.scale.x = bar.scale.x - 5;
			}
			if (FlxG.keys.justPressed("G")) {
				player.heal(1);
				//bar.scale.x = bar.scale.x + 5;
			}
			
			//if player falls into pit
			if (player.y > FlxG.height) {
				player.doDamage(1);
				//bar.scale.x = bar.scale.x - 5;
			}			
				
			super.update();		
		}
		
		private function loadLevel(l:Number):void {
			[Embed(source = "../assets/GrassTileSet.png")] var grassTiles:Class;
			[Embed(source = "../assets/l0.txt", mimeType="application/octet-stream")] var data:Class;
			var stringData:Object = new data();
			var levelData:String = stringData.toString();
			var levelArray:Array = levelData.split(',');
			level = new FlxTilemap();
			level.loadMap(FlxTilemap.arrayToCSV(levelArray, 80), grassTiles, 8, 8, 0, 1, 1);
			add(level);
			FlxG.worldBounds = new FlxRect(0, 0, level.width, level.height);
		}
		
		private function drawHealthBar():void {
			var frame:FlxSprite = new FlxSprite(4,4);
			frame.makeGraphic(52,10); //White frame for the health bar
			frame.scrollFactor.x = frame.scrollFactor.y = 0;
			add(frame);
 
			var inside:FlxSprite = new FlxSprite(5,5);
			inside.makeGraphic(50,8,0xff000000); //Black interior, 48 pixels wide
			inside.scrollFactor.x = inside.scrollFactor.y = 0;
			add(inside);
 
			bar = new FlxSprite(5,5);
			bar.makeGraphic(1,8,0xffff0000); //The red bar itself
			bar.scrollFactor.x = bar.scrollFactor.y = 0;
			bar.origin.x = bar.origin.y = 0; //Zero out the origin
			bar.scale.x = 50; //Fill up the health bar all the way
			add(bar);
		}
		
		override public function draw():void {
			if(paused)
				return pauseGroup.draw();
			super.draw();
		}
		
		private function onQuit():void {
			// Go back to the MenuState
			FlxG.switchState(new MenuState);
		}
	}
}