package ;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxObject;
import flixel.FlxG;

class Bullet extends FlxSprite
{
	public var launched:Bool;
	public var bulletColor:FlxColor;

	public function new (X:Float, Y:Float, color:FlxColor)
	{
		super(X, Y);	

		bulletColor = color;

		launched = false;
		init();
	}

	function init()
	{
		makeGraphic(4, 8, bulletColor);
		// allowCollisions = FlxObject.NONE;
		kill();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (launched && !this.isOnScreen()) {
			kill();
			launched = false;
		}
	}

	public function dispose()
	{
		kill();
		launched = false;
		setPosition(FlxG.width / 2 - 2 + FlxG.camera.scroll.x, FlxG.height / 2 - 4 + FlxG.camera.scroll.y);
	}
}