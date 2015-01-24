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

	public function new(x:Float, y:Float, ?simpleGraphic:FlxGraphicAsset)
	{
		// TODO fazer o load com o loadRotatedGraphic
		super(x, y, simpleGraphic);

		originalSpawn = new FlxPoint(x, y);
		spawn = new FlxPoint();

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

		chasePoint = FlxPoint.get(FlxG.camera.scroll.x + FlxG.width / 2,	FlxG.camera.scroll.y + FlxG.height / 2 - 150);
		this.angle = FlxAngle.angleBetweenPoint(this, chasePoint, true);
	}

	override public function activate()
	{
		revive();
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
		chasePoint.set(FlxG.camera.scroll.x + FlxG.width / 2,	FlxG.camera.scroll.y + FlxG.height / 2 - 150);
		FlxVelocity.moveTowardsPoint(this, chasePoint, 100);

		trace(this.getMidpoint());
		trace(chasePoint);

		if (chasePoint.distanceTo(this.getMidpoint()) <= 250)
		{
			state = EnemyState.Charging;
			elapsedCharge = 0;
			trace("stop");
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
		trace("PAU");
		state = EnemyState.Fleeing;
		spawn.set(originalSpawn.x + FlxG.camera.scroll.x - width, originalSpawn.y + FlxG.camera.scroll.y - height);
		this.angle = FlxAngle.angleBetweenPoint(this, spawn, true);
	}

	private function updateFlee(elapsed:Float)
	{
		spawn.set(originalSpawn.x + FlxG.camera.scroll.x - width, originalSpawn.y + FlxG.camera.scroll.y - height);
		FlxVelocity.moveTowardsPoint(this, spawn, 200);

		if (!this.isOnScreen())
			kill();
	}
}
