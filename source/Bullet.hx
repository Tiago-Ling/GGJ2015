package ;

import flixel.FlxSprite;
import flixel.util.FlxColor;

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
		scrollFactor.set(0, 0);
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

}