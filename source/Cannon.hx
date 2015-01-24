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

	var gfx:FlxSprite;
	var playerId:Int;
	var isAttached:Bool;
	var bullets:FlxTypedGroup<Bullet>;
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
					if (gfx.angle > -120) {
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
					if (gfx.angle < 120) {
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
					if (gfx.angle > -120) {
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
					if (gfx.angle < 120) {
						gfx.angle += 2;
						angleHelper.angle += 2;
					}
				}
			}
		}

		if (FlxG.keys.pressed.SPACE && fireDelay <= 0) {
			var bullet = bullets.getFirstDead();
			if (bullet != null) {
				bullet.x = gfx.x + gfx.width / 2;
				bullet.y = gfx.y + (gfx.height / 4) * 3;
				bullet.angle = gfx.angle;
				bullet.velocity.set(Math.cos(angleHelper.angle * FlxAngle.TO_RAD) * BULLET_SPEED, Math.sin(angleHelper.angle * FlxAngle.TO_RAD) * BULLET_SPEED);
				bullet.launched = true;
				bullet.revive();
				fireDelay = BULLET_DELAY;
			}
		}
	}
}