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

	public var hullHealth:Float;
	public var shieldCount:Int;

	public function new()
	{
		super();

		init();
	}

	function init()
	{
		hullHealth = 100;

		hullBar = new FlxBar(FlxG.width - 30, FlxG.height - 310, FlxBarFillDirection.BOTTOM_TO_TOP, 20, 300);
		hullBar.createColoredFilledBar(FlxColor.YELLOW, true, FlxColor.WHITE);
		hullBar.percent = 100;
		hullBar.scrollFactor.set(0,0);
		add(hullBar);

		shieldCount = MAX_SHIELD;
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
}
