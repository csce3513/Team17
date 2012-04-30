package
{
	import org.flixel.*;

	public class PlayStateLevelOne extends FlxState
	{
		public function PlayStateLevelOne()
		{
		}
		
		public var enemies:FlxGroup = new FlxGroup;
		public var boomerangs:FlxGroup = new FlxGroup;
		public var lifeCounter:FlxText;
		public var coords:FlxPoint;
		public var level:FlxTilemap;
		public var player:Player;
		private var paused:Boolean;
		public var pauseGroup:FlxGroup;
		private var quitBtn:FlxButton;
		private var cam:FlxCamera;
		private var bar:FlxSprite;
		private var fadeTimer:FlxTimer = new FlxTimer();
		private var gear:Gear;
		private var gearSpawned:Boolean = false;
		private var endLevelTimer:FlxTimer = new FlxTimer();
		private var endLevelText:FlxText = new FlxText(200, 150, 100, "You found a piece of your ship!"); 

		override public function create():void
		{
			FlxG.framerate = 30;
			FlxG.flashFramerate = 30;
			FlxG.bgColor = 0xffffffff;
			paused = false;
			pauseGroup = new FlxGroup();
			
			loadLevel();
			
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
			//loads all enemies and runs AI
			FlxG.collide();
			for (var k:int = 0; k < enemies.length; k++) {
				if (enemies.members[k].type == "spike" && enemies.members[k].getMeleeAttackZone().overlaps(player.getHitBox()))
					doSpikeAttack(enemies.members[k]);
				else if (enemies.members[k].type == "boomeranger") {
					//set boomeranger facing based on player position
					if (enemies.members[k].startingX - player.x >= 0)
						enemies.members[k].faceLeft();
					else 
						enemies.members[k].faceRight();
						
					//checks for attack zone and boomerang timing	
					if (enemies.members[k].getAttackZone().overlaps(player.getHitBox()) && !enemies.members[k].hasActiveBoomerang && enemies.members[k].attackDelay.finished && enemies.members[k].alive)
						add(enemies.members[k].throwBoomerang(enemies.members[k].startingX, enemies.members[k].startingY));
					else if (enemies.members[k].hasActiveBoomerang) {
						enemies.members[k].checkBoomerangCollisions(player);
						if (enemies.members[k].boomerangTimer.finished)
							enemies.members[k].resetBoomerang();
					}
				}
			}
					
			bar.scale.x = player.health * 5;
			
			if (FlxG.keys.justPressed("P")) {
				FlxG.mouse.hide();
				paused = !paused;
			}
			
			if (FlxG.keys.pressed("Q")) {
				enemies.kill();
			}
			
			if (paused) {
				FlxG.mouse.show();
				return pauseGroup.update();
			}
			
			if (FlxG.keys.justPressed("C")) {
				for (var i:int = 0; i < enemies.length; i++)
					if (enemies.members[i].type == "spike")
						player.attackSpike(enemies.members[i]);
					else if (enemies.members[i].type == "boomeranger")
						player.attackBoomeranger(enemies.members[i]);
				player.attackDelay.start(.3, 1);
				player.play("slash1");
			}
			
			//if player falls into a pit
			if (player.y > FlxG.height) {
				player.isInvulnerable = false;
				player.doDamage(100);
			}
			//unless it's game over, update life counter
			if (player.lives > -1) lifeCounter.text = "Lives = " + player.lives.toString();
			if (player.health < 1) {
				player.reset(player.startingX, player.startingY);
			}

			if (!gearSpawned)
				{
				if (enemies.countDead() == enemies.length) {
					gear = new Gear(305, 70)
					add(gear);
					gearSpawned = true;
				}
			}
			
			if (gearSpawned && player.overlaps(gear)) {
				endLevelText.scrollFactor.x = endLevelText.scrollFactor.y = 0;
				add(endLevelText);
				gear.visible = false;
				endLevelTimer.start(2, 1);
			}
			
			if (endLevelTimer.finished) {
				FlxG.switchState(new PlayStateLevelTwo);
			}

			super.update();
		}
		
		//loads level and eventually monster coordinate lists
		private function loadLevel():void {
			var _GroundBackdrop:Backdrop;
			var stringData:Object;
			var levelData:String;
			[Embed(source = "../assets/GrassTileSet.png")] var Tiles:Class;
			[Embed(source = "../assets/l0.txt", mimeType = "application/octet-stream")] var Data:Class;
			[Embed(source = "../assets/forest_small_color.png")] var ImgBackdrop:Class;
			_GroundBackdrop = new Backdrop( 0, 5, ImgBackdrop, .3);		
			add (_GroundBackdrop);
			stringData = new Data();
			levelData = stringData.toString(); // converts the level text file to a string for parsing.
			level = new FlxTilemap();
			//load the tilemap and draw the level
			level.loadMap(levelData, Tiles, 8, 8);
			add(level);
			//spawn player
			player = new Player(35, 220);
			add(player);
			FlxG.worldBounds = new FlxRect(0, 0, level.width, level.height);
			loadEnemies();
		}
			
		private function loadEnemies():void {
			var enemySpike:Enemy;
			var enemyBoomeranger:Boomeranger;
			var stringEnemyData:Object;
			var oneEnemyData:Array;
			var oneEnemyNumber:Array;
			
			[Embed(source = "../assets/l0Enemies.txt", mimeType = "application/octet-stream")] var enemyData:Class;
			stringEnemyData = new enemyData();
			oneEnemyData = stringEnemyData.toString().split(';');
			oneEnemyNumber = new Array;
			for (var i:int = 0; i < oneEnemyData.length; i++)
				oneEnemyNumber[i] = oneEnemyData[i].toString().split(',');
					
			for (var j:int = 0; j < oneEnemyNumber.length; j++) {
				if (oneEnemyNumber[j][0].toString() == "spike") {
					enemySpike = new Enemy(oneEnemyNumber[j][1], oneEnemyNumber[j][2], oneEnemyNumber[j][3], oneEnemyNumber[j][4], oneEnemyNumber[j][5], oneEnemyNumber[j][6]);
					add(enemySpike);
					enemies.add(enemySpike);
				}
				else if (oneEnemyNumber[j][0] == "boomeranger") {
					enemyBoomeranger = new Boomeranger(oneEnemyNumber[j][1], oneEnemyNumber[j][2], oneEnemyNumber[j][3], oneEnemyNumber[j][4], oneEnemyNumber[j][5], oneEnemyNumber[j][6]);
					add(enemyBoomeranger);
					enemies.add(enemyBoomeranger);
				}
			}
		}
		
		//draws the health bar sprites and the life counter.
		private function drawHealthBar():void {
			var frame:FlxSprite = new FlxSprite(4,4);
			frame.makeGraphic(52,10); //White frame for the health bar
			frame.scrollFactor.x = frame.scrollFactor.y = 0;
			frame.solid = false;
			add(frame);
 
			var inside:FlxSprite = new FlxSprite(5,5);
			inside.makeGraphic(50,8,0xff000000); //Black interior, 48 pixels wide
			inside.scrollFactor.x = inside.scrollFactor.y = 0;
			inside.solid = false;
			add(inside);
 
			bar = new FlxSprite(5,5);
			bar.makeGraphic(1,8,0xffff0000); //The red bar itself
			bar.scrollFactor.x = bar.scrollFactor.y = 0;
			bar.origin.x = bar.origin.y = 0; //Zero out the origin
			bar.scale.x = 50; //Fill up the health bar all the way
			bar.solid = false;
			add(bar);
			
			lifeCounter = new FlxText(60, 3, 50, "Lives = " + player.lives.toString());
			lifeCounter.scrollFactor.x = lifeCounter.scrollFactor.y = 0;
			lifeCounter.solid = false;
			add(lifeCounter);
		}
		
		override public function draw():void {
			if(paused) return pauseGroup.draw();
			super.draw();
		}
		
		private function onQuit():void {
			// Go back to the MenuState
			FlxG.switchState(new MenuState);
		}
		
		private function doSpikeAttack(e:Enemy):void {
			if (e.tryAttack(player))
				e.justAttacked();
		}
	}
}