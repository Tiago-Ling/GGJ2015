package ;

import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;
import flixel.FlxG;
import flixel.util.FlxColor;

class Player extends FlxSprite
{
	public var isAttached:Bool;

	var ship:FlxSprite;
	var idleAnim:String;

	public function new (X:Float, Y:Float, id:Int, ?SimpleGraphic:flixel.system.FlxAssets.FlxGraphicAsset)
	{
		super(X, Y, SimpleGraphic);

		ID = id;
		idleAnim = 'idle_top';

		init();
	}

	function init()
	{
		var w = 24;
		var h = 48;
		// ID == 0 ? makeGraphic(w, h, FlxColor.RED) : makeGraphic(w, h, FlxColor.BLUE);
		loadGraphic(AssetPaths.vsheet2__png, true, 41, 87);
		scale.set(0.75, 0.75);
		animation.add('idle_top', [0], 12, true);
		animation.add('idle_down', [3], 12, true);
		animation.add('idle_right', [6], 12, true);
		animation.add('walk_top',[0,1,2],12,true);
		animation.add('walk_down',[3,4,5],12,true);
		animation.add('walk_right',[6,7,8,9],12,true);
		animation.play('idle_top');
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
				animation.play('walk_top');
				idleAnim = 'idle_top';
			}

			if (FlxG.keys.pressed.DOWN) {
				velocity.y = 200;
				animation.play('walk_down');
				idleAnim = 'idle_down';
			}

			if (FlxG.keys.pressed.LEFT) {
				velocity.x = -200;
				animation.play('walk_right');
				this.flipX = true;
				idleAnim = 'idle_right';
			}

			if (FlxG.keys.pressed.RIGHT) {
				velocity.x = 200;
				animation.play('walk_right');
				this.flipX = false;
				idleAnim = 'idle_right';
			}

			if (FlxG.keys.justReleased.ANY) {
				velocity.set(0, 0);
				animation.play(idleAnim);
			}
		} else {
			if (FlxG.keys.pressed.W) {
				velocity.y = -200;
				animation.play('walk_top');
				idleAnim = 'idle_top';
			}

			if (FlxG.keys.pressed.S) {
				velocity.y = 200;
				animation.play('walk_down');
				idleAnim = 'idle_down';
			}

			if (FlxG.keys.pressed.A) {
				velocity.x = -200;
				animation.play('walk_right');
				this.flipX = true;
				idleAnim = 'idle_right';
			}

			if (FlxG.keys.pressed.D) {
				velocity.x = 200;
				animation.play('walk_right');
				this.flipX = false;
				idleAnim = 'idle_right';
			}

			if (FlxG.keys.justReleased.ANY) {
				velocity.set(0, 0);
				animation.play(idleAnim);
			}
		}
	}

}
