package ;

import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxVelocity;
import flixel.math.FlxAngle;

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

	public function new(x:Float, y:Float, ?simpleGraphic:FlxGraphicAsset)
	{
		// TODO fazer o load com o loadRotatedGraphic
		super(x, y, simpleGraphic);

		originalSpawn = new FlxPoint(x, y);
		spawn = new FlxPoint();

		chaseVelocity = FlxPoint.get(150, 300);

		this.revive();
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
		revive();
		originalSpawn.set(x, y);
		setPosition(x, y);
		chasePoint = FlxPoint.get(FlxG.camera.scroll.x + FlxG.width / 2,	FlxG.camera.scroll.y + FlxG.height / 2);
		this.angle = FlxAngle.angleBetweenPoint(this, chasePoint, true);
		state = Enemy.EnemyState.Chasing;
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
		this.velocity.y = -100;

		if (elapsedCharge >= 1)
		{
			state = EnemyState.Firing;
		}
	}

	private function updateFire(elapsed:Float)
	{
		state = EnemyState.Fleeing;
		spawn.set(originalSpawn.x + FlxG.camera.scroll.x - width, originalSpawn.y + FlxG.camera.scroll.y - height);
	}

	private function updateFlee(elapsed:Float)
	{
		var w = width;
		var h = height;
		if (originalSpawn.x < 0)
			w *= -1;
		if (originalSpawn.y < 0)
			h *= -1;

		// spawn.set(originalSpawn.x + FlxG.camera.scroll.x + w, originalSpawn.y + FlxG.camera.scroll.y + h);
		spawn.set(originalSpawn.x + w, originalSpawn.y + h);
		this.angle = FlxAngle.angleBetweenPoint(this, spawn, true);
		var speed = FlxG.random.float(chaseVelocity.x, chaseVelocity.y);
		FlxVelocity.moveTowardsPoint(this, spawn, speed);

		if (!this.isOnScreen()) {
			angle = 0;
			kill();
		}
	}
}
