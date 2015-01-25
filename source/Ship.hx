package ;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup;
import flixel.util.FlxTimer;
import flixel.math.FlxPoint;
import flixel.effects.particles.FlxEmitter;
import flixel.FlxObject;
import flixel.tweens.FlxTween;

class Ship extends FlxGroup
{
	static inline var MAX_HULL:Float = 100;

	public var hullHealth:Float;
	public var shieldCount:Int;

	var hullHUDCallback:Float->Void;

	public var players:FlxGroup;
	public var slots:FlxGroup;
	public var bullets:FlxGroup;

	public var hull:FlxSprite;
	public var nose:FlxObject;
	public var colGroup:FlxGroup;

	var cannonLeft:Cannon;
	var cannonRight:Cannon;
	var leftThruster:Thruster;
	var rightThruster:Thruster;
	var hullRepair:HullRepair;
	var pA:Player;
	var pB:Player;

	var timer:FlxTimer;

	var pos:FlxPoint;

	// var emitter:FlxEmitter;
	var exploGroup:FlxTypedGroup<FlxEmitter>;

	public var uiLayer:FlxGroup;

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

		hullHealth = 100;

		players = new FlxGroup();
		slots = new FlxGroup();
		bullets = new FlxGroup();

		//533, 321
		hull = new FlxSprite(pos.x, pos.y);
		hull.loadGraphic(AssetPaths.ship__png);
		hull.offset.set(50, 120);
		hull.width -= 100;
		hull.height -= 240;
		hull.scrollFactor.set(0, 0);
		add(hull);

		uiLayer = new FlxGroup();

		nose = new FlxObject(pos.x, pos.y - 50, hull.width, 50);
		add(nose);

		colGroup = new FlxGroup();
		colGroup.add(hull);
		colGroup.add(nose);

		cannonLeft = new Cannon(pos.x + hull.width / 4 - 55, pos.y - 70, 0);
		slots.add(cannonLeft);
		bullets.add(cannonLeft.bullets);
		add(cannonLeft);

		cannonRight = new Cannon(pos.x + (hull.width / 4) * 3 - 10, pos.y - 70, 1);
		slots.add(cannonRight);
		bullets.add(cannonRight.bullets);
		add(cannonRight);

		//Add grabbers here (ids 3 and 4)

		leftThruster = new Thruster(pos.x + hull.width / 4 - 40, pos.y + 115, 4, this);
		slots.add(leftThruster);
		add(leftThruster);

		rightThruster = new Thruster(pos.x + (hull.width / 4) * 3 - 5, pos.y + 115, 5, this);
		slots.add(rightThruster);
		add(rightThruster);

		hullRepair = new HullRepair(pos.x + hull.width / 2 - 20, pos.y + hull.height / 2 - 30, 6, this);
		hullRepair.setHullRepairCallback(repairHull);
		slots.add(hullRepair);
		add(hullRepair);

		pA = new Player(FlxG.width / 2 - 12, FlxG.height / 2 - 24, 0);
		pA.boundTo(hull);
		players.add(pA);
		add(pA);

		pB = new Player(FlxG.width / 2 - 12, FlxG.height / 2 - 24, 1);
		pB.boundTo(hull);
		players.add(pB);
		add(pB);

		timer = new FlxTimer();

		add(uiLayer);

		// hull.offset.set(50, 120);
		// hull.width -= 100;
		// hull.height -= 240;
		exploGroup = new FlxTypedGroup<FlxEmitter>();
		for (i in 0...6) {
			var emitter = new FlxEmitter();
			emitter.particleClass = ShipExplosion;
			emitter.makeParticles(120, 120, FlxColor.TRANSPARENT, 10);
			emitter.lifespan.set(0.5, 1);
			emitter.kill();
			exploGroup.add(emitter);
		}
		add(exploGroup);

		setDrag(FlxPoint.get(240, 240));
	}

	public function setDrag(drag:FlxPoint)
	{
		hull.drag.set(drag.x, drag.y);
		nose.drag.set(drag.x, drag.y);
		cannonLeft.gfx.drag.set(drag.x, drag.y);
		cannonLeft.angleHelper.drag.set(drag.x, drag.y);
		cannonRight.gfx.drag.set(drag.x, drag.y);
		cannonRight.angleHelper.drag.set(drag.x, drag.y);
		leftThruster.gfx.drag.set(drag.x, drag.y);
		rightThruster.gfx.drag.set(drag.x, drag.y);
		hullRepair.drag.set(drag.x, drag.y);
		hullRepair.repairIcon.drag.set(drag.x, drag.y);
		pA.drag.set(drag.x, drag.y);
		pB.drag.set(drag.x, drag.y);

		drag.put();
	}

	public function setGroupVelocity(velocity:Float)
	{
		hull.velocity.x = velocity;
		nose.velocity.x = velocity;
		cannonLeft.gfx.velocity.x = velocity;
		cannonLeft.angleHelper.velocity.x = velocity;
		cannonRight.gfx.velocity.x = velocity;
		cannonRight.angleHelper.velocity.x = velocity;
		leftThruster.gfx.velocity.x = velocity;
		rightThruster.gfx.velocity.x = velocity;
		hullRepair.velocity.x = velocity;
		hullRepair.repairIcon.velocity.x = velocity;
		pA.velocity.x = velocity;
		pB.velocity.x = velocity;

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
			case 6:
				hullRepair.attachPlayer(pId);
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
			case 6:
				hullRepair.dettachPlayer();
		}

		pId == 0 ? pA.isAttached = false : pB.isAttached = false;

		trace('Dettached player $pId from slot $slotId -> isAttached : ${pId == 0 ? pA.isAttached : pB.isAttached}');

	}

	public function setHullHUDCallback(callback:Float->Void)
	{
		hullHUDCallback = callback;
	}

	public function repairHull(value:Float)
	{
		hullHealth += value;
		if (hullHealth > MAX_HULL)
			hullHealth = MAX_HULL;

		hullHUDCallback(hullHealth);
	}

	public function takeHit(hit:Float, bX:Float, bY:Float)
	{
		hullHealth -= hit;
		hullHUDCallback(hullHealth);

		if (hullHealth > 0) {
			var emitter = exploGroup.recycle();
			// var emitter = explosions.getFirstDead();
			if (emitter != null) {
				emitter.setPosition(bX, bY + 100);
				emitter.start(true, 0.3, 8);
				emitter.scale.set(0.2, 0.2, 0.3, 0.3, 0.4, 0.4, 0.6, 0.6);
				emitter.revive();
				FlxG.sound.play(AssetPaths.explosion__wav, 1);
			}
		} else {
			var timer = new FlxTimer();
			var i = 0;
			timer.start(0.3, function (t:FlxTimer) {
				var emitter = exploGroup.recycle();
				// var emitter = explosions.getFirstDead();
				if (emitter != null) {
					switch (i) {
						case 0:
							emitter.setPosition(hull.x, hull.y);
						case 1:
							emitter.setPosition(hull.x + hull.width, hull.y);
						case 2:
							emitter.setPosition(hull.x, hull.y + hull.height);
						case 3:
							emitter.setPosition(hull.x + hull.width, hull.y + hull.height);
					}
					emitter.start(true, 0.7, 15);
					emitter.scale.set(0.4, 0.4, 0.6, 0.6, 0.8, 0.8, 1.2, 1.2);
					emitter.lifespan.set(1.5, 2);
					emitter.revive();
					FlxG.sound.play(AssetPaths.defeat_enemy__wav, 1);
					FlxG.camera.shake(0.02, 0.3);
				}
				i++;
				if (t.loopsLeft == 0) {
					FlxG.camera.fade(FlxColor.BLACK,3,false,function () { FlxG.switchState(new GameOverState());});
				}
			}, 4);
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

	}
}
