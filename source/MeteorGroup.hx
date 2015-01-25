package ;

import flixel.group.FlxGroup;
import flixel.FlxG;

class MeteorGroup extends FlxGroup
{
	public function new ()
	{
		super();
		
		init();
	}

	function init()
	{
		for (i in 0...30) {
			var meteor = new Meteor(0, 0);
			add(meteor);
		}
	}

	public function spawn()
	{
		if (this.countDead() > 0)
		{
			// TODO condição de spawn aleatoria?

			var meteor = cast(this.getFirstDead(), Meteor);
			meteor.x = FlxG.camera.scroll.x + FlxG.width / 2 - 16;
			meteor.y = FlxG.camera.scroll.y;
			meteor.revive();
		}
		else
		{
			var meteor = new Meteor(FlxG.camera.scroll.x + FlxG.width / 2 - 16, FlxG.camera.scroll.y);
			this.add(meteor);
		}
	}
}
