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
import flixel.addons.display.FlxBackdrop;
import flixel.effects.particles.FlxEmitter;
// import flixel.group.FlxTypedGroup;
import flixel.graphics.FlxGraphic;
import flixel.FlxObject;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	var pA:Player;
	var pB:Player;
	var ship:Ship;

	var hud:HUD;

	var meteorGroup:MeteorGroup;
	var pickupGroup:PickupGroup;
	var enemyGroup:EnemyGroup;

	var exploGroup:FlxTypedGroup<FlxEmitter>;

	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();

		// FlxG.worldBounds.set(-10000, -10000, 20000, 20000);

		this.bgColor = 0xff444444;
		// FlxG.debugger.drawDebug = true;

		FlxG.mouse.visible = false;

		// var bg = new FlxBackdrop(AssetPaths.bg_fundo__png, 0.3, 0.3, true, true);
		var bg = new RunnerBackdrop(AssetPaths.bg_fundo__png, 0.3, 0.3, true, true);
		bg.velocity.y = 100 * 0.3;
		var nebulosa = new FlxBackdrop(AssetPaths.bg_nebulosa__png, 0.7, 0.7, true, true);
		nebulosa.velocity.y = 100 * 0.7;
		var estrelas = new FlxBackdrop(AssetPaths.bg_estrelas__png, 1, 1, true, true);
		estrelas.velocity.y = 100;

		add(bg);
		add(nebulosa);
		add(estrelas);

		var w = 145;
		var h = 160;
		ship = new Ship(FlxG.width / 2 - w / 2, (FlxG.height / 2 - h / 2) + 100);
		add(ship);

		meteorGroup = new MeteorGroup(this);
		add(meteorGroup);

		pickupGroup = new PickupGroup();
		add(pickupGroup);

		exploGroup = new FlxTypedGroup<FlxEmitter>();
		for (i in 0...10) {
			var emitter = new FlxEmitter();
			emitter.particleClass = Explosion;
			emitter.makeParticles(120, 120, FlxColor.TRANSPARENT, 30);
			emitter.lifespan.set(0.5, 1);
			emitter.kill();
			exploGroup.add(emitter);
		}

		enemyGroup = new EnemyGroup(7, 3, exploGroup);
		add(enemyGroup.bullets);
		add(enemyGroup);

		hud = new HUD(enemyGroup);
		ship.setHullHUDCallback(hud.setHullHealth);
		add(hud);

		add(exploGroup);
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

		handleSlotInteraction();

		if (FlxG.keys.justReleased.F12)
		{
			Configuration.load(AssetPaths.config__xml);
		}
	}

	function checkCollisions()
	{
		FlxG.overlap(ship.bullets, enemyGroup, function (a:Bullet, b:Enemy) {
			a.dispose();
			b.takeHit(1);
			hud.addToScore(50);
		});

		FlxG.overlap(ship.colGroup, enemyGroup.bullets, function (a:FlxObject, b:Bullet) {
			b.velocity.set(0, 0);
			var center = b.getMidpoint();
			ship.takeHit(5, center.x, center.y);
			b.dispose();
		});

		FlxG.overlap(ship.colGroup, meteorGroup, function (a:FlxObject, b:Meteor) {
			ship.takeHit(45, b.x + b.width / 2, b.y + b.height);
			b.kill();
		});
	}

	function handleSlotInteraction()
	{
		var didOverlap:Bool = false;
		FlxG.overlap(ship.players, ship.slots, function (a:Player, b:FlxSprite) {
			switch (a.ID) {
				case 0:
					if (FlxG.keys.justPressed.Q) {
						if (didOverlap)
							return;

						didOverlap = true;
						if (a.isAttached) {
							ship.dettachPlayer(a.ID, b.ID);
						} else {
							ship.attachPlayer(a.ID, b.ID);
						}
					}
				case 1:
					if (FlxG.keys.justPressed.ENTER) {
						if (didOverlap)
							return;

						didOverlap = true;
						if (a.isAttached) {
							ship.dettachPlayer(a.ID, b.ID);
						} else {
							ship.attachPlayer(a.ID, b.ID);
						}
					}
			}
		});
	}
}
