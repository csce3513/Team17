package  
{
	import asunit.framework.TestSuite;
	public class TestLauncher extends TestSuite
	{
		// put test calls in this method to run them
		public function TestLauncher() 
		{
			super();
			addTest(new Tests("testInstantiated"));
			addTest(new Tests("testAddition"));
			//addTest(new ExampleTest("testFail"));
		}
		
	}

}