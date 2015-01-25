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
		this.loadGraphic(AssetPaths.explosion3__png, true, 120, 120);
		animation.add('idle', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 12, true);
		animation.play('idle');

		// this.lifespan = 0.4;
	}
}