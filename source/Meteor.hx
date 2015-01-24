package ;

import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;

class Meteor extends Spawnable
{
	private var isOnScene:Bool;

	public function new(x:Float, y:Float, ?simpleGraphic:FlxGraphicAsset)
	{
		super(x, y, simpleGraphic);
	}

	override public function init()
	{
		loadRotatedGraphic(AssetPaths.asteroide__png, 32, -1, false, true);

		isOnScene = false;

		velocity.y = -75;

		kill();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		angle += 100 * elapsed;

		if (!isOnScene && isOnScreen())
		{
			isOnScene = true;
		}
		else if (isOnScene && !isOnScreen())
		{
			kill();
			isOnScene = false;
		}
	}
}
