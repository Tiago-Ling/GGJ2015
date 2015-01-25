package ;

import flixel.group.FlxGroup;
import flixel.FlxSprite;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import flixel.FlxG;

class HUD extends FlxGroup
{
	private static inline var MAX_SHIELD:Int = 3;

	private var hullBar:FlxBar;
	private var shieldGroup:FlxGroup;

	public function new()
	{
		super();

		init();
	}

	public function init()
	{
		hullBar = new FlxBar(FlxG.width - 30, FlxG.height - 310, FlxBarFillDirection.BOTTOM_TO_TOP, 20, 300);
		hullBar.createColoredFilledBar(FlxColor.YELLOW, true, FlxColor.WHITE);
		hullBar.percent = 0;
		hullBar.scrollFactor.set(0,0);
		add(hullBar);

		shieldGroup = new FlxGroup(MAX_SHIELD);
		for (i in 0...MAX_SHIELD)
		{
			var shield = new FlxSprite(20, 20);
			shield.makeGraphic(20, 20, FlxColor.CYAN);
			shield.x = FlxG.width - 60;
			shield.y = FlxG.height - (20 + 10) * (i + 1);
			shield.scrollFactor.set(0,0);

			shieldGroup.add(shield);
		}
		add(shieldGroup);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	public function setHullHealth(percent:Float)
	{
		trace('c2: $percent');
		hullBar.percent = percent;
	}

	public function setShieldCount(count:Int)
	{
		if (count > MAX_SHIELD)
			count = MAX_SHIELD;

		for (i in 0...MAX_SHIELD)
		{
			if (i < count)
				shieldGroup.members[i].revive();
			else
				shieldGroup.members[i].kill();
		}
	}
}
