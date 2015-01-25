package ;

import flixel.group.FlxGroup;
import flixel.FlxSprite;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.text.FlxText;
import flixel.util.FlxTimer;

class HUD extends FlxGroup
{
	private static inline var MAX_SHIELD:Int = 3;

	private var hullBar:FlxBar;
	private var shieldGroup:FlxGroup;

	public var scoreNum:Int;
	public var score:FlxText;
	public var level:FlxText;
	public var time:FlxText;
	var timer:FlxTimer;
	var totalTime:Int;
	var enemyGroup:EnemyGroup;

	public function new(enemyGroup:EnemyGroup)
	{
		super();

		this.enemyGroup = enemyGroup;

		init();
	}

	public function init()
	{
		scoreNum = 0;
		hullBar = new FlxBar(FlxG.width - 30, FlxG.height - 310, FlxBarFillDirection.BOTTOM_TO_TOP, 20, 300);
		hullBar.createColoredFilledBar(FlxColor.YELLOW, true, FlxColor.WHITE);
		hullBar.percent = 100;
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

		score = new FlxText(10, 546, 300, 'Score : 000000000', 16);
		score.setBorderStyle(FlxTextBorderStyle.OUTLINE_FAST, 0x444444, 2);
		add(score);

		level = new FlxText(10, 546, 1004, 'Level 1', 16);
		level.setBorderStyle(FlxTextBorderStyle.OUTLINE_FAST, 0x444444, 2);
		level.alignment = FlxTextAlign.CENTER;
		add(level);

		time = new FlxText(10, 546, 934, 'Time : 00:00', 16);
		time.setBorderStyle(FlxTextBorderStyle.OUTLINE_FAST, 0x444444, 2);
		time.alignment = FlxTextAlign.RIGHT;
		add(time);

		totalTime = 0;
		timer = new FlxTimer();
		timer.start(1, function (t:FlxTimer) {
			totalTime++;
			var minutes = "00";
			var secs = totalTime < 10 ? "0" + Std.string(totalTime) : Std.string(totalTime);
			
			if (totalTime > 60) {
				minutes = totalTime / 60 < 10 ? "0" + Std.string(Std.int(totalTime / 60)) : Std.string(Std.int(totalTime / 60));
				secs = totalTime % 60 < 10 ? "0" + Std.string(totalTime % 60) : Std.string(totalTime % 60);
			}
			
			time.text = "Time : " + minutes + ":" + secs;

			checkEvents();

		}, 0);

	}

	function checkEvents()
	{
		if (totalTime >= 60) {
			level.text = 'Level 2';
			enemyGroup.setSpawn(6, 4);
		} else if (totalTime >= 120) {
			level.text = 'Level 3';
			enemyGroup.setSpawn(6, 5);
		}  else if (totalTime >= 180) {
			level.text = 'Level 4';
			enemyGroup.setSpawn(6, 6);
		} else if (totalTime >= 240) {
			level.text = 'Level 5';
			enemyGroup.setSpawn(5, 6);
		} else if (totalTime >= 300) {
			level.text = 'Level 6';
			enemyGroup.setSpawn(5, 7);
		} 
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	public function addToScore(value:Int)
	{
		scoreNum += value;
		score.text = 'Score : $scoreNum';
		Reg.score = scoreNum;
	}

	public function setHullHealth(percent:Float)
	{
		if (percent < hullBar.percent) {
			FlxG.camera.shake(0.01, 0.2);
		}

		FlxTween.tween(hullBar, {percent:percent}, 0.4, {type:FlxTween.ONESHOT, ease:FlxEase.sineOut});
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
