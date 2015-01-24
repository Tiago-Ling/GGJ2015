package ;

import flixel.group.FlxGroup;
import flixel.FlxG;

class PickupGroup extends FlxGroup
{
	public function spawn()
	{
		if (this.countDead() > 0)
		{
			// TODO condição de spawn aleatoria?
			var pickup = cast(this.getFirstDead(), Pickup);
			pickup.x = FlxG.width / 2 - 16;
			pickup.y = FlxG.camera.scroll.y;
			pickup.revive();
		}
		else
		{
			var pickup = new Pickup(FlxG.width / 2 - 16, 0);
			this.add(pickup);
		}
	}
}
