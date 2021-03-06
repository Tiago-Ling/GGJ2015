package ;

import flixel.effects.particles.FlxParticle;

class Explosion extends FlxParticle
{
	public function new()
	{
		super();

		init();
	}

	function init() 
	{
		this.loadGraphic(AssetPaths.explosion1__png, true, 120, 120);
		animation.add('explosion', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 12, true);
		animation.add('idle', [11], 12, true);
		animation.play('idle');

		this.lifespan = 0.3;
	}

	override public function reset(X:Float, Y:Float) {
		super.reset(X, Y);
		animation.play('explosion');
	}

	override public function kill() {
		animation.play('idle');
		super.kill();
	}
}