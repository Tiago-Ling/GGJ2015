package ;

import flixel.FlxSprite;
import flixel.FlxG;

class Cannon extends FlxSprite
{
	var playerId:Int;
	var isAttached:Bool;

	public function new(X:Float, Y:Float, id:Int) 
	{
		super(X, Y);

		ID = id;

		init();
	}	

	function init()
	{
		loadGraphic(AssetPaths.cannon2__png);
		this.origin.set(width / 2, (height / 4) * 3);
		scrollFactor.set(0, 0);
	}

	public function attachPlayer(id:Int) {
		playerId = id;
		isAttached = true;
	}

	public function dettachPlayer() {
		playerId = -1;
		isAttached = false;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		handleInput();
	}

	function handleInput() 
	{
		if (!isAttached)
			return;

		//Player 1 commands
		if (playerId == 0) {
			if (ID == 0) {
				if (FlxG.keys.pressed.LEFT) {
					if (angle < 0) {
						angle += 2;
					}
				}

				if (FlxG.keys.pressed.RIGHT) {
					if (angle > -120) {
						angle -= 2;
					}
				}
			} else {
				if (FlxG.keys.pressed.LEFT) {
					if (angle > 0) {
						angle -= 2;
					}
				}

				if (FlxG.keys.pressed.RIGHT) {
					if (angle < 120) {
						angle += 2;
					}
				}
			}
		} else {	//Player 2 commands 
			if (ID == 0) {
				if (FlxG.keys.pressed.D) {
					if (angle < 0) {
						angle += 2;
					}
				}

				if (FlxG.keys.pressed.A) {
					if (angle > -120) {
						angle -= 2;
					}
				}
			} else {
				if (FlxG.keys.pressed.D) {
					if (angle > 0) {
						angle -= 2;
					}
				}

				if (FlxG.keys.pressed.A) {
					if (angle < 120) {
						angle += 2;
					}
				}
			}
		}
	}

}