package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;

class Item extends FlxSprite
{
	public static var value:Int = 1;

	public function new(x:Float, y:Float) 
	{
		super(x, y);
		var switchType = getType();
		loadGraphic("assets/images/items/cheese.png", false);
		switch (switchType)
		{
			case Default:
				loadGraphic("assets/images/items/cheese.png", false);
				value = 1;
			case Blue:
				loadGraphic("assets/images/items/bluecheese.png", false);
				value = 5;
			case Red:
				loadGraphic("assets/images/items/redcheese.png", false);
				value = 10;
		}
	}
	override function update(elapsed:Float)
	{
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
}

enum ItemType
{
	Default;
	Blue;
	Red;
}