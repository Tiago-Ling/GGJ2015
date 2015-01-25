package ;

import flixel.FlxSprite;

class HullRepair extends FlxSprite
{
	var playerId:Int;
	var isAttached:Bool;

	public function new (X:Float, Y:Float, id:Int)
	{
		super(X, Y);

		loadGraphic(AssetPaths.repair__png);

		init();
	}

	function init()
	{
		this.scrollFactor.set(0,0);
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

		if (!isAttached)
			return;
	}
}
