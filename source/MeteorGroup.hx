package ;

import flixel.group.FlxGroup;
import flixel.FlxG;

class MeteorGroup extends FlxGroup
{
	public function spawn()
	{
		if (this.countDead() > 0)
		{
			// TODO condição de spawn aleatoria?

			var meteor = cast(this.getFirstDead(), Meteor);
			meteor.x = FlxG.width / 2 - 16;
			meteor.y = FlxG.camera.scroll.y;
			meteor.revive();
		}
		else
		{
			var meteor = new Meteor(FlxG.width / 2 - 16, 0);
			this.add(meteor);
		}
	}
}
