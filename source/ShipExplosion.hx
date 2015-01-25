package ;

import flixel.effects.particles.FlxParticle;

class ShipExplosion extends FlxParticle
{
	public function new()
	{
		super();

		init();
	}

	function init() 
	{
		this.loadGraphic(AssetPaths.explosion2__png, true, 120, 120);
		animation.add('explosion', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 12, true);
		animation.add('idle', [10], 12, true);
		animation.play('idle');

		this.lifespan = 0.3;
		this.scale.set(0.5, 0.5);
	}

	override public function reset(X:Float, Y:Float) {
		super.reset(X, Y);
		animation.play('explosion');
	}

	override public function kill() {
		super.kill();
		animation.play('idle');
	}
}