package  
{
	import asunit.errors.InvocationTargetError;
	import asunit.framework.TestCase;
	import org.flixel.*;
	import worldObject;
	import Enemy;
	import Player;
	
	public class Tests extends TestCase
	{
		public var player:Player;
		public var target:Player;
		public var leftKey:Boolean, rightKey:Boolean, space:Boolean;
		
		// calls the test called from TestLauncher
		public function Tests(testMethod:String) 
		{
			super(testMethod);
		}

		//public function TestLeftMovement():void {
			//leftKey = true;
			//if (leftKey)
				//player.acceleration.x = -player.maxVelocity.x * 4;
			//var result:Number = player.acceleration.x;
			//assertEquals("Expected:40000 Received:"+result, result, -40000);
		//}
		
		//public function TestRightMovement():void {
			//rightKey = true;
			//if (rightKey)
				//player.acceleration.x = player.maxVelocity.x * 4;
			//var result:Number = player.acceleration.x;
			//assertEquals("Expected:40000 Received:"+result, result, 40000);
		//}
		
		//public function TestJump():void {
			//var player:Player = new Player;
			//space = true;
			//if (space)
				//player.velocity.y = -player.maxVelocity.y / 1.5;
			//var result:Number = player.velocity.y;
			//assertEquals("Expected:6666.667 Received:"+result, result, -(10000/1.5));
		//}
		
		public function TestWorldObject():void {
			var o:worldObject = new worldObject();
			//assertFalse("Expected true, Received: " + o.exists.toString(), o.exists);
			// tests to see if not spawned, fails
			//assertTrue("Expected true, Received: " + o.exists.toString(), o.exists);
			// tests to see if spawned, passes
			//assertTrue(o.getHealth() < 1);
			//tests to see if the object is alive. assumed to be destroyable, written to fail
			assertTrue(o.getHealth() > 0);
			// tests for life. passes
		}
		
		public function TestTestEnemy():void {
			var e:Enemy = new Enemy();
			assertFalse("Expected true, Received: " + e.exists.toString(), e.exists);
			// tests to see if not spawned, fails
			assertTrue("Expected true, Received: " + e.exists.toString(), e.exists);
			// tests to see if spawned, passes
			assertTrue(e.getHealth() < 1);
			//tests to see if the object is alive. assumed to be destroyable, written to fail
			assertTrue(e.getHealth() > 0);
			// tests for life. passes
		}
<<<<<<< HEAD
		
		public function TestHealth():void {
			var player:Player = new Player();
			player.doDamage(7);
			player.heal(3);
			assertEquals("Expected: 6 Received:" + player.getHealth(), player.getHealth(), 6);
		}
		
		//public function TestGetAngleMetod():void {
           //var playerX:Number = 60;
           //var playerY:Number = 200;
           //var mouseX:Number = 120;
           //var mouseY:Number = 100;
           //var result:Number = getAngle(playerX,playerY,mouseX,mouseY);
           //assertEquals("Expected: 30.963757, Received: " + result, result, 30.963757);
		//}

		public function testAttackTargetInRange(): void {
            var player:Player = new Player;
            var target:Player = new Player;
            //player.attack();
            var targetHealthAfter:Number = target.getHealth();
            assertEquals("Expected:50, Recived: " + targetHealthAfter, targetHealthAfter, 50);
		}

		public function testAttackTargetOutOfRange(): void{
            var player:Player = new Player;
            var target:Player = new Player;
            //player.attack();
            var targetHealthAfter:Number = target.getHealth();
            assertEquals("Expected:100, Recived: " + targetHealthAfter, targetHealthAfter, 50);
		}
=======
>>>>>>> 38c0c1ce7ec8e10339fb95ebaab9685895316d27
	}
}