package ;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxObject;
import flixel.FlxG;

class Bullet extends FlxSprite
{
	public var launched:Bool;

	public function new (X:Float, Y:Float)
	{
		super(X, Y);	

		launched = false;
		init();
	}

	function init()
	{
		makeGraphic(4, 8, FlxColor.RED);
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