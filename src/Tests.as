package  
{
	import asunit.framework.TestCase;
	
	public class Tests extends TestCase
	{
		private var _instance:Example;
		
		// calls the test called from TestLauncher
		public function Tests(testMethod:String) 
		{
			super(testMethod);
		}

		// called on test class instantiation to construct the class and destroy it when it is done testing
		protected override function setUp():void {
			_instance = new Example();
		}
		protected override function tearDown():void {
			_instance = null;
		}

		public function testInstantiated():void {
			assertTrue("Example instantiated", _instance is Example);
		}

		public function testFail():void {
			assertFalse("failing test", true);
		}

		public function testAddition():void {
			var result:Number = _instance.add(2,3);
			assertEquals("Expected:5 Received:"+result, result, 5);
		}
	}

}