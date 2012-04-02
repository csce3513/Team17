package  
{
	import asunit.textui.TestRunner;
	public class AsUnitTestRunner extends TestRunner
	{
		
		public function AsUnitTestRunner() 
		{
			start(TestLauncher, null, TestRunner.SHOW_TRACE);
		}
		
	}

}