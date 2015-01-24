package ;

import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;
import flixel.FlxG;
import flixel.util.FlxColor;

class Player extends FlxSprite
{
	public var isAttached:Bool;

	var ship:FlxSprite;

	public function new (X:Float, Y:Float, id:Int, ?SimpleGraphic:flixel.system.FlxAssets.FlxGraphicAsset)
	{
		super(X, Y, SimpleGraphic);

		ID = id;

		init();
	}

	function init() 
	{
		ID == 0 ? makeGraphic(32, 64, FlxColor.RED) : makeGraphic(32, 64, FlxColor.BLUE);
		// setPosition(FlxG.width / 2 - width / 2, FlxG.height / 2 - height / 2);
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

		handleInput();
	}

	function handleInput()
	{
		if (isAttached)
			return;

		if (ID == 0) {
			if (FlxG.keys.pressed.UP) {
				velocity.y = -200;
			}

			if (FlxG.keys.pressed.DOWN) {
				velocity.y = 200;
			}

			if (FlxG.keys.pressed.LEFT) {
				velocity.x = -200;
			}

			if (FlxG.keys.pressed.RIGHT) {
				velocity.x = 200;
			}

			if (FlxG.keys.justReleased.ANY) {
				velocity.set(0, 0);
			}
		} else {
			if (FlxG.keys.pressed.W) {
				velocity.y = -200;
			}

			if (FlxG.keys.pressed.S) {
				velocity.y = 200;
			}

			if (FlxG.keys.pressed.A) {
				velocity.x = -200;
			}

			if (FlxG.keys.pressed.D) {
				velocity.x = 200;
			}

			if (FlxG.keys.justReleased.ANY) {
				velocity.set(0, 0);
			}
		}
	}

}