package ;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.group.FlxSpriteGroup;

class Ship extends FlxSpriteGroup
{
	var hull:FlxSprite;
	var cannonLeft:Cannon;
	var cannonRight:Cannon;

	public function new (X:Float, Y:Float)
	{
		super(X, Y);

		init();
	}

	function init()
	{
		this.scrollFactor.set(0, 0);

		hull = new FlxSprite(0, 0);
		hull.loadGraphic(AssetPaths.ship__png);
		add(hull);

		cannonLeft = new Cannon(hull.width / 4 - 25, 50, 0);
		add(cannonLeft);

		cannonRight = new Cannon((hull.width / 4) * 3 - 10, 50, 1);
		add(cannonRight);

	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

	}

}