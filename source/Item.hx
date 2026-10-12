package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;

class Item extends FlxSprite
{
	public var value:Int;
	public var healthIncrease:Int;

	public var SPEED:Float = 0;

	public function new(x:Float, y:Float) 
	{
		super(x, y);
		switch getType()
		{
			case Default:
				loadGraphic(Paths.item('cheese'), false);
				value = 1;
				healthIncrease = 1;
			case Blue:
				loadGraphic(Paths.item('bluecheese'), false);
				SPEED = 75;
				value = 5;
				healthIncrease = 2;
			case Red:
				loadGraphic(Paths.item('redcheese'), false);
				SPEED = 200;
				value = 10;
				healthIncrease = 4;
			case Lunchly:
				loadGraphic(Paths.item('lunchly'), false);
				value = 2;
				healthIncrease = 2;
		}
	}
	override function update(elapsed:Float)
	{
		updateMovement();
		super.update(elapsed);
	}

	function updateMovement()
	{
		var up:Bool = false;
		var down:Bool = false;
		var left:Bool = false;
		var right:Bool = false;
		var rSpeed:Float;

		up = FlxG.random.bool(3);
		down = FlxG.random.bool(3);
		left = FlxG.random.bool(3);
		right = FlxG.random.bool(3);

		if (up && down)
			up = down = false;
		if (left && right)
			left = right = false;

		switch getType()
		{
			case Default | Lunchly:
				rSpeed = 0.8;
			case Blue:
				rSpeed = 1.1;
			case Red:
				rSpeed = 1.4;
		}

		if (up || down || left || right)
		{
			if (up)
				velocity.y = SPEED * -1 * rSpeed;
			if (down)
				velocity.y = SPEED * rSpeed;
			if (left)
				velocity.x = SPEED * -1 * rSpeed;
			if (right)
				velocity.x = SPEED * rSpeed;
		}
	}

	public function getType():ItemType
	{
		if (FlxG.save.data.speedMode)
			return Lunchly;
		var rng:Int = FlxG.random.int(1, 10);

		if (rng <= 1)
			return Red;
		if (rng <= 3)
			return Blue;
		return Default;
	}
}

enum ItemType
{
	Default;
	Blue;
	Red;
	Lunchly;
}