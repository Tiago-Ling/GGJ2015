package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

class CreditState extends FlxState
{
	private var bg:FlxSprite;

	override public function create():Void
	{
		super.create();

		bg = new FlxSprite();
		bg.loadGraphic(AssetPaths.credits__png);
		add(bg);
	}

	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (FlxG.keys.pressed.ESCAPE)
			FlxG.switchState(new IntroState());
	}
}
