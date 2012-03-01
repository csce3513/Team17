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
		
		public function TestWorldObject():void {
			var o = new worldObject();
			assertFalse("Expected true, Received: " + o.exists.toString(), o.exists); // tests to see if not spawned, fails
			assertTrue("Expected true, Received: " + o.exists.toString(), o.exists); // tests to see if spawned, passes
			assertTrue(o.getHealth() < 1); //tests to see if the object is alive.  assumed to be destroyable, written to fail
			assertTrue(o.getHealth() > 0);  // tests for life.  passes
		}
	}

}