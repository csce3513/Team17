package
{
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		public function PlayState()
		{
		}
		
		public var enemies:FlxGroup = new FlxGroup;
		public var coordBox:FlxText;
		public var lifeCounter:FlxText;
		public var coords:FlxPoint = new FlxPoint(0, 0);
		public var level:FlxTilemap;
		public var testEnemy:Enemy;
		public var player:Player;
		private var paused:Boolean;
		public var pauseGroup:FlxGroup;
		private var quitBtn:FlxButton;
		private var cam:FlxCamera;
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
			
			testEnemy = new Enemy(60, 67, 60, 67, 95, 67);
			enemies.add(testEnemy);
			add(testEnemy);
			
			// adds a constantly updating textbox of the player's coordinates.  for testing
			coordBox = new FlxText(250, 4, 200);
			coordBox.scrollFactor.x = coordBox.scrollFactor.y = 0;
			coordBox.color = 0xfff0000;
			add(coordBox);
			
			drawHealthBar();
			
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
			if (testEnemy.getMeleeAttackZone().overlaps(player.getHitBox())) testEnemy.attack(player);
			bar.scale.x = player.health * 5;5
			updateCoordBox();
			
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
			}
			
			if (FlxG.keys.justPressed("G")) {
				player.heal(1);
			}
			
			if (FlxG.keys.justPressed("C")) {
				player.attack(testEnemy);
			}
			
			//if player falls into a pit
			if (player.y > FlxG.height) {
				player.doDamage(1);
			}
			if (player.lives > -1) lifeCounter.text = "Lives = " + player.lives.toString();
			super.update();		
		}
		
		private function loadLevel(l:Number):void {
			[Embed(source = "../assets/GrassTileSet.png")] var grassTiles:Class;
			[Embed(source = "../assets/l0.txt", mimeType = "application/octet-stream")] var data:Class;
			[Embed(source = "../assets/forest2.jpg")] var ImgBackdrop:Class;
			var _GroundBackdrop:Backdrop = new Backdrop( -240, -300, ImgBackdrop, .3);		
			add (_GroundBackdrop);
			var stringData:Object = new data();
			var levelData:String = stringData.toString(); // converts the level text file to a string for parsing.
			level = new FlxTilemap();
			//level.loadMap(FlxTilemap.arrayToCSV(levelArray, 80), grassTiles, 8, 8);
			level.loadMap(levelData, grassTiles, 8, 8);
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
			
			lifeCounter = new FlxText(60, 3, 50, "Lives = " + player.lives.toString());
			lifeCounter.scrollFactor.x = lifeCounter.scrollFactor.y = 0;
			add(lifeCounter);
		}
		
		public function updateCoordBox():void {
			coords = player.getScreenXY();
			coordBox.text = "X: " + coords.x.toFixed(0).toString() + ", Y: " + coords.y.toFixed(0).toString();
		}
		
		override public function draw():void {
			if(paused) return pauseGroup.draw();
			super.draw();
		}
		
		private function onQuit():void {
			// Go back to the MenuState
			FlxG.switchState(new MenuState);
		}
	}
}