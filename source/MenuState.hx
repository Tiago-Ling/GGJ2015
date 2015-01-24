package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxSpriteUtil;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	var spr:Player;
	var boat:FlxSprite;

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();

		this.bgColor = 0xff444444;

		var bg = new flixel.addons.display.FlxBackdrop(AssetPaths.download__jpeg, 1, 1, true, true);
		// bg.loadGraphic(AssetPaths);
		// bg.setPosition(FlxG.width / 2 - w / 2, FlxG.height / 2 - h / 2);
		add(bg);

		boat = new FlxSprite(0, 0);
		boat.makeGraphic(250, 450, FlxColor.YELLOW);
		boat.setPosition(FlxG.width / 2 - boat.width / 2, FlxG.height / 2 - boat.height / 2);
		boat.scrollFactor.set(0, 0);
		add(boat);

		spr = new Player(300, 300);
		spr.boundTo(boat);
		add(spr);
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		FlxG.camera.scroll.y -= 100 * elapsed;
	}
}