package ;

import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;
import flixel.FlxG;
import flixel.util.FlxColor;

class Player extends FlxSprite
{
	var ship:FlxSprite;
	var keys:Array<Int>;

	public function new (X:Float, Y:Float, ?SimpleGraphic:flixel.system.FlxAssets.FlxGraphicAsset)
	{
		super(X, Y, SimpleGraphic);

		init();
	}

	function init() 
	{
		makeGraphic(32, 64, FlxColor.RED);
		setPosition(FlxG.width / 2 - width / 2, FlxG.height / 2 - height / 2);
		scrollFactor.set(0, 0);

		this.acceleration.set(0, 0);
		this.maxVelocity.set(300, 300);
	}

	public function boundTo(spr:FlxSprite)
	{
		ship = spr;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxSpriteUtil.bound(this, ship.x, ship.x + ship.width, ship.y - 24, ship.y + ship.height);

		if (FlxG.keys.pressed.UP) {
			// velocity.y -= 200 * elapsed;
			velocity.y = -200;
		}

		if (FlxG.keys.pressed.DOWN) {
			// velocity.y += 200 * elapsed;
			velocity.y = 200;
		}

		if (FlxG.keys.pressed.LEFT) {
			// velocity.x -= 200 * elapsed;
			velocity.x = -200;
		}

		if (FlxG.keys.pressed.RIGHT) {
			// velocity.x += 200 * elapsed;
			velocity.x = 200;
		}

		if (FlxG.keys.justReleased.ANY) {
			velocity.set(0, 0);
		}
	}

}