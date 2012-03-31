package  
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author dylan
	 */
	public class meleeWeapon extends FlxSprite
	{
		var swingSpeed = 1.0;
		var weaponName = "Weapon";
		var weapon : FlxSprite;
		[Embed(source = "../assets/sword1.png")] private var weaponSprite:Class;

		public function meleeWeapon(xval:Number, yval:Number)
		{
		super(xval, yval);
		loadGraphic(weaponSprite, false, false);
		weapon = new FlxSprite(50, 50);//.loadGraphic(weaponSprite, false, false);
		super.update();
		}
		
		public function swingWeapon()
		{
		//weapon.play(); nb 
		}
	}

}