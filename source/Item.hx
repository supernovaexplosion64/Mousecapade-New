package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;

class Item extends FlxSprite
{
	public static var value:Int;
	public static var speed:Int;

	public function new(x:Float, y:Float) 
	{
		super(x, y);
		var switchType = getType();
		loadGraphic("assets/images/items/cheese.png", false);
		value = 1;
		switch (switchType)
		{
			case Default:
				loadGraphic("assets/images/items/cheese.png", false);
				value = 1;
			case Blue:
				loadGraphic("assets/images/items/bluecheese.png", false);
				speed = 75;
				value = 5;
			case Red:
				loadGraphic("assets/images/items/redcheese.png", false);
				speed = 200;
				value = 10;
		}
	}
	override function update(elapsed:Float)
	{
		super.update(elapsed);
		updateHitbox();
	}

	public function getType()
	{
		var rng:Int = FlxG.random.int(1, 10);

		if (rng >= 4)
			return Default;
		if (rng >= 2)
			return Blue;
		return Red;
	}
	function updateMovement()
	{
		var up:Bool = false;
		var down:Bool = false;
		var left:Bool = false;
		var right:Bool = false;

		up = FlxG.random.bool(3);
		down = FlxG.random.bool(3);
		left = FlxG.random.bool(3);
		right = FlxG.random.bool(3);

		if (up && down)
			up = down = false;
		if (left && right)
			left = right = false;

		if (up || down || left || right)
		{
			var newAngle:Float = 0;
			if (up)
			{
				newAngle = -90;
				if (left)
					newAngle -= 45;
				else if (right)
					newAngle += 45;
			}
			else if (down)
			{
				newAngle = 90;
				if (left)
					newAngle += 45;
				else if (right)
					newAngle -= 45;
			}
			else if (left)
				newAngle = 180;
			else if (right)
				newAngle = 0;
			velocity.setPolarDegrees(speed, newAngle);
		}
	}
}

enum ItemType
{
	Default;
	Blue;
	Red;
}