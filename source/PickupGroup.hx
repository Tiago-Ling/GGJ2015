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
			pickup.x = FlxG.camera.scroll.x;
			pickup.y = FlxG.camera.scroll.y;
			pickup.revive();
		}
		else
		{
			var pickup = new Pickup(FlxG.camera.scroll.x, FlxG.camera.scroll.y);
			this.add(pickup);
		}
	}
}
