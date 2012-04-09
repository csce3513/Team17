package  
{
	import asunit.framework.Test;
	import asunit.framework.TestSuite;
	public class TestLauncher extends TestSuite
	{
		// put test calls in this method to run them
		public function TestLauncher() 
		{
			super();
			addTest(new Tests("TestHealth"));
			//addTest(new Tests("TestGetAngleMetod"));
			//addTest(new Tests("testAttackTargetInRange"));
			//addTest(new Tests("testAttackTargetOutOfRange"));
			addTest(new Tests("TestWorldObject"));
			addTest(new Tests("TestTestEnemy"));
			addTest(new Tests("TestGetAngleMethod"));
			addTest(new Tests("testAttackTargetInRange"));
			addTest(new Tests("testAttackTargetOutOfRange"));
		}
		
	}

}