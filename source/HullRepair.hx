package ;

import flixel.FlxSprite;

class HullRepair extends FlxSprite
{
	static inline var HULL_REPAIR_TIME:Float = 2.5;
	static inline var HULL_REPAIR_FACTOR:Float = 10;

	var playerId:Int;
	var isAttached:Bool;

	var hullRepairCallback:Float->Void;

	var timeElapsed:Float;

	public function new (X:Float, Y:Float, id:Int)
	{
		super(X, Y);

		ID = id;

		init();
	}

	function init()
	{
		loadGraphic(AssetPaths.repair__png);

		this.scrollFactor.set(0,0);

		timeElapsed = 0;
	}

	public function attachPlayer(id:Int) {
		playerId = id;
		isAttached = true;
	}

	public function dettachPlayer() {
		playerId = -1;
		isAttached = false;
	}

	public function setHullRepairCallback(callback:Float->Void)
	{
		hullRepairCallback = callback;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (!isAttached)
			return;

		timeElapsed += elapsed;
		if (timeElapsed >= HULL_REPAIR_TIME)
		{
			timeElapsed -= HULL_REPAIR_TIME;
			hullRepairCallback(HULL_REPAIR_FACTOR);
		}
	}
}
