package  
{
	import asunit.framework.TestSuite;
	public class TestLauncher extends TestSuite
	{
		// put test calls in this method to run them
		public function TestLauncher() 
		{
			super();
			addTest(new Tests("TestLeftMovement"));
			addTest(new Tests("TestRightMovement"));
			addTest(new Tests("TestJump"));
			addTest(new Tests("TestHealth"));
		}
		
	}

}