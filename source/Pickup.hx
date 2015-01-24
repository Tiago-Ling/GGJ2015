package ;

import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;

class Pickup extends Spawnable
{
	public function new(x:Float, y:Float, ?simpleGraphic:FlxGraphicAsset)
	{
		// TODO fazer o load com o loadRotatedGraphic
		super(x, y, simpleGraphic);
	}

	override public function init()
	{
		makeGraphic(32, 32, FlxColor.GREEN);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

	}
}
