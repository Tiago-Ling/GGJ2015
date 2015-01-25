package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;

class GameOverState extends FlxState
{
	private var bg:FlxSprite;

	override public function create():Void
	{
		super.create();

		FlxG.mouse.visible = false;

		bg = new FlxSprite();
		bg.loadGraphic(AssetPaths.game_over__jpg);
		add(bg);
	}

	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ANY) {
			FlxG.camera.fade(FlxColor.BLACK,0.3, false, function () {
				FlxG.switchState(new IntroState());
			});
		}
	}
}
