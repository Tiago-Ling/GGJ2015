package ;

import flixel.group.FlxGroup;
import flixel.FlxG;
import flixel.math.FlxPoint;

class EnemyGroup extends FlxGroup
{

	public function new()
	{
		super();

		init();
	}

	function init()
	{
		for (i in 0...20) {
			var enemy = new Enemy(0, 0);
			add(enemy);
		}
	}

	public function spawn(position:FlxPoint)
	{
		if (this.countDead() > 0)
		{
			// TODO condição de spawn aleatoria?

			var enemy = cast(this.getFirstDead(), Enemy);
			enemy.x = position.x + FlxG.camera.scroll.x;
			enemy.y = position.y + FlxG.camera.scroll.y;
			enemy.revive();
		}
		else
		{
			var enemy = new Enemy(position.x + FlxG.camera.scroll.x, FlxG.camera.scroll.y);
			add(enemy);
		}
	}
}
