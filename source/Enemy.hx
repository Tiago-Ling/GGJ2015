package ;

import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.math.FlxPoint;

enum EnemyState {
	Chasing;
	Charging;
	Firing;
}

class Enemy extends Spawnable
{
	private var state:EnemyState;

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
	}

	private function updateChase(elapsed:Float)
	{

	}

	private function updateCharge(elapsed:Float)
	{
	}

	private function updateFire(elapsed:Float)
	{

	}

}
