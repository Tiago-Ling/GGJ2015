package ;

import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxVelocity;
import flixel.math.FlxAngle;
import flixel.group.FlxGroup;
import flixel.effects.particles.FlxEmitter;

enum EnemyState {
	Idle;
	Chasing;
	Charging;
	Firing;
	Fleeing;
}

class Enemy extends Spawnable
{
	private var state:EnemyState;
	private var chasePoint:FlxPoint;

	private var elapsedCharge:Float;

	private var originalSpawn:FlxPoint;
	private var spawn:FlxPoint;

	public var chaseVelocity:FlxPoint;
	var explosions:FlxTypedGroup<FlxEmitter>;

	public function new(x:Float, y:Float, explosions:FlxTypedGroup<FlxEmitter>, ?simpleGraphic:FlxGraphicAsset)
	{
		// TODO fazer o load com o loadRotatedGraphic
		super(x, y, simpleGraphic);

		originalSpawn = new FlxPoint(x, y);
		spawn = new FlxPoint();

		chaseVelocity = FlxPoint.get(150, 300);

		this.explosions = explosions;

		kill();
	}

	public function setState(state:EnemyState)
	{
		this.state = state;
	}

	override public function init()
	{
		loadGraphic(AssetPaths.nave__png);

		state = Enemy.EnemyState.Idle;

		elapsedCharge = 0;
	}

	override public function activate(x:Float, y:Float)
	{
		originalSpawn.set(x, y);
		setPosition(x, y);
		chasePoint = FlxPoint.get(FlxG.camera.scroll.x + FlxG.width / 2,	FlxG.camera.scroll.y + FlxG.height / 2);
		this.angle = FlxAngle.angleBetweenPoint(this, chasePoint, true);
		state = Enemy.EnemyState.Chasing;

		health = 2;

		revive();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (state == EnemyState.Chasing)
			updateChase(elapsed);
		else if (state == EnemyState.Charging)
			updateCharge(elapsed);
		else if (state == EnemyState.Firing)
			updateFire(elapsed);
		else if (state == EnemyState.Fleeing)
			updateFlee(elapsed);
	}

	private function updateChase(elapsed:Float)
	{
		chasePoint.set(FlxG.camera.scroll.x + FlxG.width / 2,	FlxG.camera.scroll.y + FlxG.height / 2);
		FlxVelocity.moveTowardsPoint(this, chasePoint, 200);

		if (chasePoint.distanceTo(this.getMidpoint()) <= 250)
		{
			state = EnemyState.Charging;
			elapsedCharge = 0;
		}
	}

	private function updateCharge(elapsed:Float)
	{
		elapsedCharge += elapsed;

		this.velocity.x = 0;
		this.velocity.y = 0;

		if (elapsedCharge >= 1)
		{
			state = EnemyState.Firing;
		}
	}

	private function updateFire(elapsed:Float)
	{
		var w = width;
		var h = height;
		if (originalSpawn.x < 0)
			w *= -1;
		if (originalSpawn.y < 0)
			h *= -1;

		spawn.set(originalSpawn.x + FlxG.camera.scroll.x + w, originalSpawn.y + FlxG.camera.scroll.y + h);

		state = EnemyState.Fleeing;
	}

	private function updateFlee(elapsed:Float)
	{
		if (!this.isOnScreen()) {
			dispose();
		}

		var w = width;
		var h = height;
		if (originalSpawn.x < 0)
			w *= -1;
		if (originalSpawn.y < 0)
			h *= -1;

		spawn.set(originalSpawn.x + FlxG.camera.scroll.x + w, originalSpawn.y + FlxG.camera.scroll.y + h);
		this.angle = FlxAngle.angleBetweenPoint(this, spawn, true);
		var speed = FlxG.random.float(chaseVelocity.x, chaseVelocity.y);
		FlxVelocity.moveTowardsPoint(this, spawn, speed);
	}

	public function dispose()
	{
		angle = 0;
		state = EnemyState.Idle;
		elapsedCharge = 0;
		kill();
	}

	public function takeHit(dmg:Int)
	{
		if (this.health > 0) {
			trace('Damage taken $health');
			health -= dmg;
			FlxG.sound.play(AssetPaths.explosion__wav, 1);
		} else {

			var emitter = explosions.recycle();
			// var emitter = explosions.getFirstDead();
			emitter.focusOn(this);
			emitter.start(true, 0.3, 10);
			emitter.revive();
			dispose();
			FlxG.sound.play(AssetPaths.defeat_enemy__wav, 1);
		}
	}
}
