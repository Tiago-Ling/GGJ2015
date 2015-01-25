package ;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.group.FlxGroup;
// import flixel.group.FlxTypedGroup;
import flixel.util.FlxColor;
import flixel.math.FlxAngle;
import flixel.FlxObject;

class Cannon extends FlxGroup
{
	public static var BULLET_DELAY:Float = 25;
	public static var BULLET_SPEED:Float = 600;

	public var bullets:FlxTypedGroup<Bullet>;

	var gfx:FlxSprite;
	var playerId:Int;
	var isAttached:Bool;
	var fireDelay:Float;
	var angleHelper:FlxObject;

	public function new(X:Float, Y:Float, id:Int)
	{
		super();

		this.ID = id;
		fireDelay = 0;

		init(X, Y, id);
	}

	function init(X:Float, Y:Float, id:Int)
	{
		bullets = new FlxTypedGroup<Bullet>(50);
		for (i in 0...50) {
			var bullet = new Bullet(0, 0);
			bullets.add(bullet);
		}
		add(bullets);

		gfx = new FlxSprite(X, Y);
		gfx.loadGraphic(AssetPaths.cannon__png);
		gfx.origin.set(gfx.width / 2, (gfx.height / 4) * 3);
		gfx.scrollFactor.set(0, 0);
		gfx.ID = id;
		add(gfx);

		angleHelper = new FlxObject(X, Y);
		angleHelper.angle = -90;

		gfx.offset.x = 10;
		gfx.offset.y = 10;
		gfx.width -= 20;
		gfx.height -= 20;
	}

	public function attachPlayer(id:Int) {
		playerId = id;
		isAttached = true;
	}

	public function dettachPlayer() {
		playerId = -1;
		isAttached = false;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (fireDelay > 0)
			fireDelay -= 100 * elapsed;

		handleInput();
	}

	function handleInput()
	{
		if (!isAttached)
			return;

		//Player 1 commands
		if (playerId == 0) {
			if (ID == 0) {
				if (FlxG.keys.pressed.RIGHT) {
					if (gfx.angle < 0) {
						gfx.angle += 2;
						angleHelper.angle += 2;
					}
				}

				if (FlxG.keys.pressed.LEFT) {
					if (gfx.angle > -140) {
						gfx.angle -= 2;
						angleHelper.angle -= 2;
					}
				}
			} else {
				if (FlxG.keys.pressed.LEFT) {
					if (gfx.angle > 0) {
						gfx.angle -= 2;
						angleHelper.angle -= 2;
					}
				}

				if (FlxG.keys.pressed.RIGHT) {
					if (gfx.angle < 140) {
						gfx.angle += 2;
						angleHelper.angle += 2;
					}
				}
			}
		} else {	//Player 2 commands
			if (ID == 0) {
				if (FlxG.keys.pressed.D) {
					if (gfx.angle < 0) {
						gfx.angle += 2;
						angleHelper.angle += 2;
					}
				}

				if (FlxG.keys.pressed.A) {
					if (gfx.angle > -140) {
						gfx.angle -= 2;
						angleHelper.angle -= 2;
					}
				}
			} else {
				if (FlxG.keys.pressed.A) {
					if (gfx.angle > 0) {
						gfx.angle -= 2;
						angleHelper.angle -= 2;
					}
				}

				if (FlxG.keys.pressed.D) {
					if (gfx.angle < 140) {
						gfx.angle += 2;
						angleHelper.angle += 2;
					}
				}
			}
		}

		if (ID == 0) {
			if (FlxG.keys.pressed.UP && fireDelay <= 0) {
				var bullet = bullets.getFirstDead();
				if (bullet != null) {
					bullet.setPosition(gfx.x + gfx.width / 2 + FlxG.camera.scroll.x, gfx.y + (gfx.height / 4) * 3 + FlxG.camera.scroll.y);
					bullet.angle = gfx.angle;
					bullet.velocity.set(Math.cos(angleHelper.angle * FlxAngle.TO_RAD) * BULLET_SPEED, Math.sin(angleHelper.angle * FlxAngle.TO_RAD) * BULLET_SPEED);
					bullet.launched = true;
					bullet.revive();
					fireDelay = BULLET_DELAY;
					FlxG.sound.play(AssetPaths.tiro__wav);
				}
			}
		} else{
			if (FlxG.keys.pressed.W && fireDelay <= 0) {
				var bullet = bullets.getFirstDead();
				if (bullet != null) {
					bullet.setPosition(gfx.x + gfx.width / 2 + FlxG.camera.scroll.x, gfx.y + (gfx.height / 4) * 3 + FlxG.camera.scroll.y);
					bullet.angle = gfx.angle;
					bullet.velocity.set(Math.cos(angleHelper.angle * FlxAngle.TO_RAD) * BULLET_SPEED, Math.sin(angleHelper.angle * FlxAngle.TO_RAD) * BULLET_SPEED);
					bullet.launched = true;
					bullet.revive();
					fireDelay = BULLET_DELAY;
					FlxG.sound.play(AssetPaths.tiro__wav);
				}
			}
		}
	}
}
