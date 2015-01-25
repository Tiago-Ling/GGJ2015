package ;

import flixel.group.FlxGroup;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.effects.particles.FlxEmitter;

class EnemyGroup extends FlxGroup
{
	public var bullets:FlxTypedGroup<Bullet>;

	var spawnDelay:Float;
	var numEnemies:Int;
	var spawnCounter:Float;

	var positions:Array<FlxPoint>;
	var usedPos:Array<Int>;

	public function new(spawnDelay:Float, numEnemies:Int, explosions:FlxTypedGroup<FlxEmitter>)
	{
		super();

		this.spawnDelay = spawnDelay;
		this.numEnemies = numEnemies;
		spawnCounter = 0;

		positions = [FlxPoint.get(-100,-100),
					 FlxPoint.get(FlxG.width / 4, -100),
					 FlxPoint.get((FlxG.width / 4) * 3, -100),
					 FlxPoint.get(FlxG.width, -100),
					 FlxPoint.get(-100, FlxG.height / 2),
					 FlxPoint.get(FlxG.width, FlxG.height / 2),
					 FlxPoint.get(-100, FlxG.height),
					 FlxPoint.get(FlxG.width, FlxG.height)];
		usedPos = [];
		init(explosions);
	}

	function init(explosions:FlxTypedGroup<FlxEmitter>)
	{
		bullets = new FlxTypedGroup<Bullet>(50);
		for (i in 0...50) {
			var bullet = new Bullet(0, 0);
			bullets.add(bullet);
		}
		add(bullets);

		for (i in 0...30) {
			var enemy = new Enemy(0, 0, explosions, bullets);
			add(enemy);
		}
	}

	public function setSpawn(spawnDelay:Float, numEnemies:Int)
	{
		this.spawnDelay = spawnDelay;
		this.numEnemies = numEnemies;
	}

	public function spawn(position:FlxPoint)
	{
		var enemy = cast(recycle(), Enemy);
		if (enemy != null) {
			if (position.y > 0)
				enemy.chaseVelocity.y += 100;

			enemy.activate(position.x + FlxG.camera.scroll.x, position.y + FlxG.camera.scroll.y);
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (spawnCounter <= 0) {
			var arr = [];
			var index = -1;
			for (i in 0...numEnemies) {
				if (arr.length > 0)
					index = FlxG.random.int(0, positions.length - 1, arr);
				else
					index = FlxG.random.int(0, positions.length - 1);

				spawn(positions[index]);

				arr.push(index);
			}

			spawnCounter = spawnDelay;
		}

		spawnCounter -= elapsed;
	}
}
