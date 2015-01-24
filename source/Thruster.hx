package ;

import flixel.FlxSprite;
import flixel.effects.particles.FlxEmitter;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.addons.effects.FlxTrail;
import flixel.FlxG;
import flixel.group.FlxGroup;

class Thruster extends FlxGroup
{
	var position:FlxPoint;
	var gfx:FlxSprite;
	var rocket:FlxEmitter;

	var playerId:Int;
	var isAttached:Bool;
	var isThrusting:Bool;

	public function new (X:Float, Y:Float, id:Int)
	{
		super();

		ID = id;

		position = FlxPoint.get(X, Y);

		init();
	}

	function init()
	{
		playerId = -1;
		isAttached = false;
		isThrusting = false;

		gfx = new FlxSprite(position.x, position.y);
		// gfx.makeGraphic(32, 32, FlxColor.YELLOW);
		gfx.loadGraphic(AssetPaths.truster___png);
		gfx.scrollFactor.set(0, 0);
		gfx.ID = ID;
		add(gfx);

		// rocket = new FlxTrail(gfx, AssetPaths.granadeBlow__png, 64, 2, 0.5, 0.1);
		rocket = new FlxEmitter(position.x, position.y);

		rocket.loadParticles(AssetPaths.granadeBlow__png, 50, 16, true, true);
		for (particle in rocket.members) {
			particle.scrollFactor.set(0, 0);
		}
		rocket.scale.set(0.5, 1, 1.5, 3);
		rocket.alpha.set(0.2, 0.4, 0.6, 0.8);
		rocket.velocity.set(50, 50, 150, 150);
		rocket.acceleration.set(15, 15, 45, 45);
		rocket.speed.set(5, 15, 30, 60);
		rocket.lifespan.set(10, 50);
		rocket.launchAngle.set(45 , 90);
		
		// if (ID == 4) {
		// 	rocket.launchAngle.set(-45, -90);
		// } else {
		// 	rocket.launchAngle.set(45 , 90);
		// }

		// explosion.setScale(0.5,1,1.5,3);
		// explosion.setAlpha(0.2,0.4,0.6,0.8);
		// // explosion.setMotion(225,32,0.3,270,72,1.2);
		// explosion.setMotion(135,32,0.2,270,72,0.7);

		// rocket.scrollFactor.set(0, 0);
		rocket.ID = ID;
		rocket.kill();
		add(rocket);

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

		handleInput(elapsed);
	}

	function handleInput(elapsed:Float)
	{
		if (!isAttached)
			return;

		if (playerId == 0) {
			if (ID == 4) { //left
				if (FlxG.keys.pressed.LEFT && !isThrusting) {
					isThrusting = true;
					rocket.revive();
					rocket.setPosition(gfx.x - 20, gfx.y);
					rocket.start(true, 0.3, 10);
					FlxG.camera.scroll.x += 100 * elapsed;
				}

				if (FlxG.keys.justReleased.LEFT && isThrusting) {
					rocket.kill();
					isThrusting = false;
				}
			} else { //right
				if (FlxG.keys.pressed.RIGHT) {
					isThrusting = true;
					rocket.revive();
					rocket.setPosition(gfx.x + 52, gfx.y);
					rocket.start(true, 0.3, 10);
					FlxG.camera.scroll.x -= 100 * elapsed;
				}

				if (FlxG.keys.justReleased.RIGHT && isThrusting) {
					rocket.kill();
					isThrusting = false;
				}
			}
		} else {
			if (ID == 4) { //left
				if (FlxG.keys.pressed.A) {
					isThrusting = true;
					rocket.revive();
					rocket.setPosition(gfx.x + 52, gfx.y);
					rocket.start(true, 0.3, 10);
					FlxG.camera.scroll.x -= 100 * elapsed;
				}

				if (FlxG.keys.justReleased.A && isThrusting) {
					rocket.kill();
					isThrusting = false;
				}
			} else { //right
				if (FlxG.keys.pressed.D) {
					isThrusting = true;
					rocket.revive();
					rocket.setPosition(gfx.x + 52, gfx.y);
					rocket.start(true, 0.3, 10);
					FlxG.camera.scroll.x += 100 * elapsed;
				}

				if (FlxG.keys.justReleased.D && isThrusting) {
					rocket.kill();
					isThrusting = false;
				}
			}
		}

	}
}