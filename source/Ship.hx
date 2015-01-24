package ;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup;
import flixel.util.FlxTimer;

class Ship extends FlxSpriteGroup
{
	public var players:FlxGroup;
	public var slots:FlxGroup;

	var hull:FlxSprite;
	var cannonLeft:Cannon;
	var cannonRight:Cannon;
	var pA:Player;
	var pB:Player;

	var timer:FlxTimer;

	public function new (X:Float, Y:Float)
	{
		super(X, Y);

		init();
	}

	function init()
	{
		this.scrollFactor.set(0, 0);

		players = new FlxGroup();
		slots = new FlxGroup();

		hull = new FlxSprite(0, 0);
		hull.loadGraphic(AssetPaths.ship__png);
		add(hull);

		cannonLeft = new Cannon(hull.width / 4 - 25, 50, 0);
		slots.add(cannonLeft);
		add(cannonLeft);

		cannonRight = new Cannon((hull.width / 4) * 3 - 10, 50, 1);
		slots.add(cannonRight);
		add(cannonRight);

		pA = new Player(100, 100, 0);
		pA.boundTo(hull);
		players.add(pA);
		add(pA);

		pB = new Player(148, 100, 1);
		pB.boundTo(hull);
		players.add(pB);
		add(pB);

		timer = new FlxTimer();

	}

	/**
	*
	* slotId	
	* 0 - Cannon Left
	* 1 - Cannon Right
	* 2 - Grabber Left
	* 3 - Grabber Right
	*
	*/
	public function attachPlayer(pId:Int, slotId:Int)
	{
		switch (slotId) {
			case 0:
				cannonLeft.attachPlayer(pId);
			case 1:
				cannonRight.attachPlayer(pId);
			case 2:
				trace('Grabber A unavailable!');
			case 3:
				trace('Grabber B unavailable!');
		}

		timer.start(0.1, function (t:FlxTimer) {
			pId == 0 ? pA.isAttached = true : pB.isAttached = true;
		}, 1);
	}

	public function dettachPlayer(pId:Int, slotId:Int)
	{
		switch (slotId) {
			case 0:
				cannonLeft.dettachPlayer();
			case 1:
				cannonRight.dettachPlayer();
			case 2:
				trace('Grabber A unavailable!');
			case 3:
				trace('Grabber B unavailable!');
		}

		timer.start(0.1, function (t:FlxTimer) {
			pId == 0 ? pA.isAttached = false : pB.isAttached = false;
		}, 1);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

	}

}