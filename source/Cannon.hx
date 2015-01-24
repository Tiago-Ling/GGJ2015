package ;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;

class Cannon extends FlxGroup
{
	var gfx:FlxSprite;
	var playerId:Int;
	var isAttached:Bool;

	var bullets:FlxGroup;

	public function new(X:Float, Y:Float, id:Int) 
	{
		super();

		this.ID = id;

		init(X, Y, id);
	}	

	function init(X:Float, Y:Float, id:Int)
	{
		gfx = new FlxSprite(X, Y);
		gfx.loadGraphic(AssetPaths.cannon2__png);
		gfx.origin.set(gfx.width / 2, (gfx.height / 4) * 3);
		gfx.scrollFactor.set(0, 0);
		gfx.ID = id;
		add(gfx);

		bullets = new FlxGroup(50);
		for (i in 0...50) {
			var bullet = new FlxSprite(0, 0);
			bullet.makeGraphic(8, 16, FlxColor.RED);
			bullet.kill();
			bullets.add(bullet);
		}
		add(bullets);
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
					}
				}

				if (FlxG.keys.pressed.LEFT) {
					if (gfx.angle > -120) {
						gfx.angle -= 2;
					}
				}
			} else {
				if (FlxG.keys.pressed.LEFT) {
					if (gfx.angle > 0) {
						gfx.angle -= 2;
					}
				}

				if (FlxG.keys.pressed.RIGHT) {
					if (gfx.angle < 120) {
						gfx.angle += 2;
					}
				}
			}
		} else {	//Player 2 commands 
			if (ID == 0) {
				if (FlxG.keys.pressed.D) {
					if (gfx.angle < 0) {
						gfx.angle += 2;
					}
				}

				if (FlxG.keys.pressed.A) {
					if (gfx.angle > -120) {
						gfx.angle -= 2;
					}
				}
			} else {
				if (FlxG.keys.pressed.A) {
					if (gfx.angle > 0) {
						gfx.angle -= 2;
					}
				}

				if (FlxG.keys.pressed.D) {
					if (gfx.angle < 120) {
						gfx.angle += 2;
					}
				}
			}
		}

		if (FlxG.keys.pressed.SPACE) {
			var bullet = cast(bullets.getFirstDead(), FlxSprite);
			if (bullet != null) {
				bullet.x = gfx.x;
				bullet.y = gfx.y;
				bullet.angle = gfx.angle;
				bullet.velocity.set(0, 300);
				bullet.revive();
			}
		}
	}
}