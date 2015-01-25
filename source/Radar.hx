package ;

import flixel.FlxSprite;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.FlxG;

class Radar extends FlxSprite
{
	var timer:FlxTimer;
	public function new (X:Float, Y:Float)
	{
		super(X, Y);

		init();
	}

	function init()
	{
		loadGraphic(AssetPaths.radar_sheet__png, true, 150, 150);
		animation.add('idle', [0,1,2,3,4,5,6,7],12, true);
		animation.play('idle');

		scale.set(0.75, 0.75);

		timer = new FlxTimer();

		kill();
	}

	public function activate(x:Float, y:Float)
	{
		setPosition(x, y);

		trace('Radar position : $x,$y');

		revive();
		alpha = 0.7;

		FlxG.sound.play(AssetPaths.SFX_ALERT__wav, 0.5);

		timer.start(5, function (t:FlxTimer) {
			FlxTween.tween(this, {alpha:0}, 0.3, {type:FlxTween.ONESHOT, onComplete:function (tween:FlxTween) {
					kill();
				}});
		}, 1);
	}

}