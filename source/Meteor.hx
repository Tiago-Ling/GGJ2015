package ;

import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;

class Meteor extends Spawnable
{
	private var isOnScene:Bool;

	public function new(x:Float, y:Float, ?simpleGraphic:FlxGraphicAsset)
	{
		// TODO fazer o load com o loadRotatedGraphic
		super(x, y, simpleGraphic);
	}

	override public function init()
	{
		makeGraphic(32, 32, FlxColor.GRAY);

		isOnScene = false;

		kill();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

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
