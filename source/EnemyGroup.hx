package ;

import flixel.group.FlxGroup;
import flixel.FlxG;

class EnemyGroup extends FlxGroup
{
	public function spawn()
	{
		if (this.countDead() > 0)
		{
			// TODO condição de spawn aleatoria?

			var enemy = cast(this.getFirstDead(), Enemy);
			enemy.x = FlxG.camera.scroll.x;
			enemy.y = FlxG.camera.scroll.y;
			enemy.revive();
		}
		else
		{
			var enemy = new Enemy(FlxG.camera.scroll.x, FlxG.camera.scroll.y);
			this.add(enemy);
		}
	}
}
