package  
{
	import asunit.framework.TestCase;
	import org.flixel.*;
	
	public class Tests extends TestCase
	{
		private var _instance:Example;
		public var player:FlxObject;
		public var leftKey:Boolean, rightKey:Boolean, space:Boolean;
		
		// calls the test called from TestLauncher
		public function Tests(testMethod:String) 
		{
			super(testMethod);
			player = new FlxObject();
		}

		// called on test class instantiation to construct the class and destroy it when it is done testing
		protected override function setUp():void {
			_instance = new Example();
		}
		protected override function tearDown():void {
			_instance = null;
		}

		public function TestLeftMovement():void {
			leftKey = true;
			if (leftKey)
				player.acceleration.x = -player.maxVelocity.x * 4;
			var result:Number = player.acceleration.x;
			assertEquals("Expected:40000 Received:"+result, result, -40000);
		}
		
		public function TestRightMovement():void {
			rightKey = true;
			if (rightKey)
				player.acceleration.x = player.maxVelocity.x * 4;
			var result:Number = player.acceleration.x;
			assertEquals("Expected:40000 Received:"+result, result, 40000);
		}
		
		public function TestJump():void {
			space = true;
			if (space)
				player.velocity.y = -player.maxVelocity.y / 1.5;
			var result:Number = player.velocity.y;
			assertEquals("Expected:6666.667 Received:"+result, result, -(10000/1.5));
		}
		
		public function TestHealth():void {
			var player:Player = new Player();
			player.doDamage(7);
			player.heal(3);
			assertEquals("Expected: 6 Received:" + player.getHealth(), player.getHealth(), 6);
		}
		
		public function TestGetAngleMetod():void{
           var playerX:Number = 60;
           var playerY:Number = 200;
           var mouseX:Number = 120;
           var mouseY:Number = 100;
           var result:Number = getAngle(playerX,playerY,mouseX,mouseY);
           assertEquals("Expected: 30.963757, Received: " + result, result, 30.963757);
}

		public function testAttackTargetInRange(): void{
            var player:FlxSprite = new FlxSprite(10,15);
            var target:FlxSprite = new FlxSprite(15,15);
            player.attack();
            var targetHealthAfter:Number = target.getHealth();
            assertEquals("Expected:50, Recived: " + targetHealthAfter, targetHealthAfter, 50);
		}

		public function testAttackTargetOutOfRange(): void{
            var player:FlxSprite = new FlxSprite(10,15);
            var target:FlxSprite = new FlxSprite(45,15);
            player.attack();
            var targetHealthAfter:Number = target.getHealth();
            assertEquals("Expected:100, Recived: " + targetHealthAfter, targetHealthAfter, 50);
		}
	}

}