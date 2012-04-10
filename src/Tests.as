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
			var e:Enemy = new Enemy(0, 0);
			assertFalse("Expected true, Received: " + e.exists.toString(), e.exists);
			// tests to see if not spawned, fails
			assertTrue("Expected true, Received: " + e.exists.toString(), e.exists);
			// tests to see if spawned, passes
			assertTrue(e.health < 1);
			//tests to see if the object is alive. assumed to be destroyable, written to fail
			assertTrue(e.health > 0);
			// tests for life. passes
		}
		
		public function TestHealth():void {
			var player:Player = new Player(0, 0);
			player.doDamage(7);
			player.heal(3);
			assertEquals("Expected: 6 Received:" + player.health, player.health, 6);
		}

		public function testAttackTargetInRange(): void {
            var player:Player = new Player(30, 0);
			player.acceleration.x = -1;
			player.acceleration.x = 0;
            var target:Enemy = new Enemy(10, 0);
            player.attack(target);
            assertEquals("Expected: 4, Recived: " + target.health, target.health, 4);
		}

		public function testAttackTargetOutOfRange(): void{
            var player:Player = new Player(40, 0);
			player.acceleration.x = -1;
			player.acceleration.x = 0;
            var target:Enemy = new Enemy(0, 0);
            player.attack(target);
            assertEquals("Expected: 5, Recived: " + target.health, target.health, 5);
		}
	}
}