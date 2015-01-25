package ;

import flixel.group.FlxGroup;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.FlxState;

class MeteorGroup extends FlxGroup
{
	static var METEOR_TIME:Float = 12;
	// static var METEOR_TIME:Float = 5;
	static var METEOR_CHANCE:Float = 40;

	var positions:Array<FlxPoint>;
	var timeCounter:Float;
	var currentChance:Float;

	var radar:Radar;

	public function new (state:FlxState)
	{
		super();
		
		init(state);
	}

	function init(state:FlxState)
	{
		timeCounter = METEOR_TIME;
		currentChance = METEOR_CHANCE;

		positions = [FlxPoint.get(306, -500),
					 FlxPoint.get(512, -500),
					 FlxPoint.get(560, -500)];

		for (i in 0...10) {
			var meteor = new Meteor(0, 0);
			add(meteor);
		}

		radar = new Radar(0, 0);
		state.add(radar);
	}

	public function spawnAt(pos:FlxPoint)
	{
		var meteor = cast(recycle(), Meteor);
		if (meteor != null) {
			meteor.x = pos.x;
			meteor.y = pos.y;
			meteor.activate();
			radar.activate(pos.x, 10);
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		timeCounter -= elapsed;

		if (timeCounter <= 0) {
			var spawnMeteor = FlxG.random.bool(currentChance);

			if (spawnMeteor) {
				trace('Meteor coming!');
				timeCounter = METEOR_TIME;
				currentChance = METEOR_CHANCE;

				var index = FlxG.random.int(0, positions.length - 1);
				trace('meteor position : ${positions[index]}');
				spawnAt(positions[index]);
			} else {
				timeCounter = METEOR_TIME * 0.75;
				currentChance = METEOR_CHANCE + 20;
			}
		}
	}
}
