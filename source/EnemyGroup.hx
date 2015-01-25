package ;

import flixel.group.FlxGroup;
import flixel.FlxG;
import flixel.math.FlxPoint;

class EnemyGroup extends FlxGroup
{
	var spawnDelay:Float;
	var numEnemies:Int;
	var spawnCounter:Float;

	var positions:Array<FlxPoint>;
	var usedPos:Array<Int>;

	public function new(spawnDelay:Float, numEnemies:Int)
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
		init();
	}

	function init()
	{
		for (i in 0...30) {
			var enemy = new Enemy(0, 0);
			enemy.kill();
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
		if (this.countDead() > 0)
		{
			// TODO condição de spawn aleatoria?

			var enemy = cast(this.getFirstDead(), Enemy);
			if (position.y > 0)
				enemy.chaseVelocity.y += 100;
				// enemy.chaseVelocity.set(enemy.chaseVelocity.x * 2, enemy.chaseVelocity.y + 100);

			enemy.activate(position.x + FlxG.camera.scroll.x, position.y + FlxG.camera.scroll.y);
		}
		else
		{
			var enemy = new Enemy(position.x + FlxG.camera.scroll.x, FlxG.camera.scroll.y);
			add(enemy);
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (spawnCounter <= 0) {
			for (i in 0...numEnemies) {
				trace('enemy spawned');
				var index = FlxG.random.int(0, positions.length - 1);
				spawn(positions[index]);
			}

			spawnCounter = spawnDelay;
		}

		spawnCounter -= elapsed;
	}
}
