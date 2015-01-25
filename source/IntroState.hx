package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

class IntroState extends FlxState
{
	private var bg:FlxSprite;

	override public function create():Void
	{
		super.create();

		bg = new FlxSprite();
		bg.loadGraphic(AssetPaths.fundo__png);
		add(bg);
	}

	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (FlxG.keys.pressed.ENTER)
			FlxG.switchState(new MenuState());

		if (FlxG.keys.pressed.ESCAPE)
			FlxG.switchState(new CreditState());

		if (FlxG.keys.pressed.T)
			FlxG.switchState(new TutorialState());
	}
}
