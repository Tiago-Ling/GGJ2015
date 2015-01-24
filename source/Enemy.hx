package ;

import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.math.FlxVelocity;

enum EnemyState {
	Chasing;
	Charging;
	Firing;
	Fleeing;
}

class Enemy extends Spawnable
{
	private var state:EnemyState;

	private var elapsedCharge:Float;

	public function new(x:Float, y:Float, ?simpleGraphic:FlxGraphicAsset)
	{
		// TODO fazer o load com o loadRotatedGraphic
		super(x, y, simpleGraphic);
	}

	override public function init()
	{
		makeGraphic(32, 32, FlxColor.ORANGE);

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
		var point = new FlxPoint(FlxG.camera.scroll.x + FlxG.width / 2,	FlxG.camera.scroll.y + FlxG.height / 2);

		FlxVelocity.moveTowardsPoint(this, point, 100);

		trace(point.distanceTo(this.getMidpoint()));

		if (point.distanceTo(this.getMidpoint()) <= 100)
		{
			state = EnemyState.Charging;
			trace("stop");
		}
	}

	private function updateCharge(elapsed:Float)
	{
		elapsedCharge += elapsed;

		if (elapsedCharge >= 1000)
		{
			state = EnemyState.Firing;
			trace("PAU");
		}
	}

	private function updateFire(elapsed:Float)
	{

	}

	private function updateFlee(elapsed:Float)
	{

	}

}
