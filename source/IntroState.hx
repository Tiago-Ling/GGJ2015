package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;

class IntroState extends FlxState
{
	private var bg:FlxSprite;

	override public function create():Void
	{
		super.create();

		FlxG.mouse.visible = false;

		bg = new FlxSprite();
		bg.loadGraphic(AssetPaths.menu__jpg);
		add(bg);
	}

	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		//Play the game
		if (FlxG.keys.justPressed.ENTER) {
			FlxG.camera.fade(FlxColor.BLACK,0.3, false, function () {
				FlxG.switchState(new MenuState());
			});
		}

		//Credits
		if (FlxG.keys.justPressed.C) {
			FlxG.camera.fade(FlxColor.BLACK,0.3, false, function () {
				FlxG.switchState(new CreditState());
			});
		}

		//How To
		if (FlxG.keys.justPressed.X)
			FlxG.camera.fade(FlxColor.BLACK,0.3, false, function () {
				FlxG.switchState(new TutorialState());
			});
	}
}
