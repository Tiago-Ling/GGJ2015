package ;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

class Spawnable extends FlxSprite
{
	public function new(x:Float, y:Float, ?simpleGraphic:FlxGraphicAsset)
	{
		super(x, y, simpleGraphic);

		init();
	}

	public function init()
	{

	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

	}
}
