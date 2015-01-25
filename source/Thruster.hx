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
	public var gfx:FlxSprite;
	public var rocket:FlxEmitter;

	var playerId:Int;
	var isAttached:Bool;
	var isThrusting:Bool;
	var ship:Ship;

	public function new (X:Float, Y:Float, id:Int, ship:Ship)
	{
		super();

		ID = id;

		this.ship = ship;

		position = FlxPoint.get(X, Y);

		init();
	}

	function init()
	{
		playerId = -1;
		isAttached = false;
		isThrusting = false;

		gfx = new FlxSprite(position.x, position.y);
		gfx.loadGraphic(AssetPaths.truster___png);
		gfx.scrollFactor.set(0, 0);
		gfx.ID = ID;
		add(gfx);

		rocket = new FlxEmitter(position.x, position.y);
		rocket.loadParticles(AssetPaths.granadeBlow__png, 50, 16, true, true);
		// rocket.scale.set(0.75, 1, 1.5, 3);
		rocket.scale.set(0.3, 0.3, 1.2, 1.2);
		rocket.alpha.set(0.4, 0.6, 0.8, 1);
		rocket.lifespan.set(0.5, 1.5);

		if (ID == 4) {
			rocket.velocity.set(-250, 0, -275, 0, -300, 0, -350, 0);
			rocket.acceleration.set(45, 0, 60, 0, 75, 0, 95, 0);
			rocket.speed.set(100, 175, 325, 425);
			rocket.launchAngle.set(165, 195);
		} else {
			rocket.velocity.set(250, 0, 275, 0, 300, 0, 350, 0);
			rocket.acceleration.set(45, 0, 60, 0, 75, 0, 95, 0);
			rocket.speed.set(100, 175, 325, 425);
			rocket.launchAngle.set(-15, 15);
		}

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
				if (FlxG.keys.justPressed.A && !isThrusting) {
					isThrusting = true;
					rocket.revive();
					rocket.setPosition(gfx.x - 20, gfx.y);
					rocket.start(false, 0.1, 20);
					// FlxG.camera.scroll.x += 100 * elapsed;

					// ship.velocity.x = 300;
					ship.setGroupVelocity(300);
				}

				if (FlxG.keys.justReleased.A && isThrusting) {
					//rocket.kill();
					isThrusting = false;
				}
			} else { //right
				if (FlxG.keys.justPressed.D) {
					isThrusting = true;
					rocket.revive();
					rocket.setPosition(gfx.x + 52, gfx.y);
					rocket.start(false, 0.1, 10);
					// FlxG.camera.scroll.x -= 100 * elapsed;

					// ship.velocity.x = -300;
					ship.setGroupVelocity(-300);
				}

				if (FlxG.keys.justReleased.D && isThrusting) {
					//rocket.kill();
					isThrusting = false;
				}
			}
		} else {
			if (ID == 4) { //left
				if (FlxG.keys.justPressed.LEFT) {
					isThrusting = true;
					rocket.revive();
					rocket.setPosition(gfx.x - 20, gfx.y);
					rocket.start(false, 0.1, 10);
					// FlxG.camera.scroll.x -= 100 * elapsed;

					// ship.velocity.x = 300;
					ship.setGroupVelocity(300);
				}

				if (FlxG.keys.justReleased.LEFT && isThrusting) {
					// rocket.kill();
					isThrusting = false;
				}
			} else { //right
				if (FlxG.keys.justPressed.RIGHT) {
					isThrusting = true;
					rocket.revive();
					rocket.setPosition(gfx.x + 52, gfx.y);
					rocket.start(false, 0.1, 10);
					// FlxG.camera.scroll.x += 100 * elapsed;

					// ship.velocity.x = -300;
					ship.setGroupVelocity(-300);
				}

				if (FlxG.keys.justReleased.RIGHT && isThrusting) {
					// rocket.kill();
					isThrusting = false;
				}
			}
		}

	}
}
