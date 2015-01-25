package ;

import flixel.FlxSprite;
import flixel.FlxG;

class HullRepair extends FlxSprite
{
	static inline var HULL_REPAIR_TIME:Float = 1;
	static inline var HULL_REPAIR_FACTOR:Float = 2.5;

	var playerId:Int;
	var isAttached:Bool;

	var hullRepairCallback:Float->Void;

	var timeElapsed:Float;

	var ship:Ship;

	public var repairIcon:FlxSprite;

	public function new (X:Float, Y:Float, id:Int, ship:Ship)
	{
		super(X, Y);

		ID = id;
		this.ship = ship;

		init();
	}

	function init()
	{
		loadGraphic(AssetPaths.repair__png);
		this.scrollFactor.set(0,0);

		offset.x = 5;
		offset.y = 5;
		width -= 10;
		height -= 10;

		timeElapsed = 0;

		repairIcon = new FlxSprite(this.x, this.y - 75);
		repairIcon.loadGraphic(AssetPaths.chave2__png,true,58,81);
		repairIcon.animation.add('idle',[0,1,2,3,4],12,true);
		repairIcon.animation.play('idle');
		// repairIcon.kill();
		repairIcon.visible = false;
		ship.uiLayer.add(repairIcon);
	}

	public function attachPlayer(id:Int) {
		playerId = id;
		isAttached = true;

		// repairIcon.revive();
		repairIcon.visible = true;
	}

	public function dettachPlayer() {
		playerId = -1;
		isAttached = false;

		// repairIcon.kill();
		repairIcon.visible = false;
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
			FlxG.sound.play(AssetPaths.SFX_Furadeira__wav, 0.75);
			hullRepairCallback(HULL_REPAIR_FACTOR);
		}
	}
}
