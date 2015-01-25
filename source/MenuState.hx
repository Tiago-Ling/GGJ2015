package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup;
import flixel.util.FlxSpriteUtil;
import flixel.math.FlxPoint;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	var pA:Player;
	var pB:Player;
	var ship:Ship;

	var meteorGroup:MeteorGroup;
	var pickupGroup:PickupGroup;
	var enemyGroup:EnemyGroup;

	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();

		this.bgColor = 0xff444444;
		FlxG.debugger.drawDebug = true;

		var bg = new flixel.addons.display.FlxBackdrop(AssetPaths.download__png, 1, 1, true, true);
		add(bg);

		var w = 145;
		var h = 160;
		ship = new Ship(FlxG.width / 2 - w / 2, (FlxG.height / 2 - h / 2) + 100);
		add(ship);

		meteorGroup = new MeteorGroup();
		add(meteorGroup);

		pickupGroup = new PickupGroup();
		add(pickupGroup);

		enemyGroup = new EnemyGroup(5, 5);
		add(enemyGroup);

		// enemyGroup.spawn(FlxPoint.weak(0, 0));
	}

	/**
	 * Function that is called when this state is destroyed - you might want to
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		checkCollisions();

		FlxG.camera.scroll.y -= 100 * elapsed;

		// TODO spawn test: remover
		if (meteorGroup.countDead() == -1 && meteorGroup.countLiving() == -1)
		{
			meteorGroup.spawn();
		}
		if (meteorGroup.countDead() >= 0 && meteorGroup.countLiving() == 0)
		{
			meteorGroup.spawn();
		}

		handleSlotInteraction();

		if (FlxG.keys.justReleased.F12)
		{
			Configuration.load(AssetPaths.config__xml);
		}
	}

	function checkCollisions()
	{
		FlxG.overlap(ship.bullets, enemyGroup, function (a:Bullet, b:Enemy) {
			trace('Collision -> bullet x enemy');
			a.kill();
			b.kill();
		});
	}

	function handleSlotInteraction()
	{
		if (FlxG.keys.justPressed.E) {
			var didOverlap:Bool = false;
			FlxG.overlap(ship.players, ship.slots, function (a:Player, b:FlxSprite) {
				if (didOverlap)
					return;

				didOverlap = true;
				if (a.isAttached) {
					ship.dettachPlayer(a.ID, b.ID);
				} else {
					ship.attachPlayer(a.ID, b.ID);
				}
			});
		}
	}
}
