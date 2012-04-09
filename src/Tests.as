package  
{
	import asunit.errors.InvocationTargetError;
	import asunit.framework.TestCase;
	import org.flixel.*;
	
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
		
		public function TestWorldObject():void {
			var o:worldObject = new worldObject();
			assertFalse("Expected true, Received: " + o.exists.toString(), o.exists);
			// tests to see if not spawned, fails
			assertTrue("Expected true, Received: " + o.exists.toString(), o.exists);
			// tests to see if spawned, passes
			assertTrue(o.getHealth() < 1);
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
	}
}