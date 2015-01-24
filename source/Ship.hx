package ;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup;
import flixel.util.FlxTimer;
import flixel.math.FlxPoint;

class Ship extends FlxGroup
{
	public var players:FlxGroup;
	public var slots:FlxGroup;

	var hull:FlxSprite;
	var cannonLeft:Cannon;
	var cannonRight:Cannon;
	var leftThruster:Thruster;
	var rightThruster:Thruster;
	var pA:Player;
	var pB:Player;

	var timer:FlxTimer;

	var pos:FlxPoint;

	public function new (X:Float, Y:Float)
	{
		// super(X, Y);
		super();

		pos = FlxPoint.get(X, Y);

		init();
	}

	function init()
	{
		// this.scrollFactor.set(0, 0);

		players = new FlxGroup();
		slots = new FlxGroup();

		//533, 321
		hull = new FlxSprite(pos.x, pos.y);
		hull.loadGraphic(AssetPaths.ship__png);
		// hull.offset.set(100, 0);
		// hull.width -= 200;
		hull.scrollFactor.set(0, 0);
		add(hull);

		cannonLeft = new Cannon(pos.x + hull.width / 4 - 25, pos.y, 0);
		slots.add(cannonLeft);
		add(cannonLeft);

		cannonRight = new Cannon(pos.x + (hull.width / 4) * 3 - 10, pos.y, 1);
		slots.add(cannonRight);
		add(cannonRight);

		//Add grabbers here (ids 3 and 4)

		leftThruster = new Thruster(pos.x + hull.width / 4 - 100, pos.y + 150, 4);
		slots.add(leftThruster);
		add(leftThruster);

		rightThruster = new Thruster(pos.x + (hull.width / 4) * 3 + 50, pos.y + 150, 5);
		slots.add(rightThruster);
		add(rightThruster);

		pA = new Player(pos.x + 100, pos.y + 200, 0);
		pA.boundTo(hull);
		players.add(pA);
		add(pA);

		pB = new Player(pos.x + 150, pos.y + 200, 1);
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
	* 4 - Left Thruster
	* 5 - Right Thruster
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
			case 4:
				leftThruster.attachPlayer(pId);
			case 5:
				rightThruster.attachPlayer(pId);
		}

		pId == 0 ? pA.isAttached = true : pB.isAttached = true;

		trace('Attached player $pId to slot $slotId -> isAttached : ${pId == 0 ? pA.isAttached : pB.isAttached}');
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
			case 4:
				leftThruster.dettachPlayer();
			case 5:
				rightThruster.dettachPlayer();
		}

		pId == 0 ? pA.isAttached = false : pB.isAttached = false;

		trace('Dettached player $pId from slot $slotId -> isAttached : ${pId == 0 ? pA.isAttached : pB.isAttached}');

	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

	}
}