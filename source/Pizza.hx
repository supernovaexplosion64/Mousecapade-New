package;

import flixel.FlxG;
import flixel.FlxSprite;

class Pizza extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);
		switch (getType())
		{
			case Default:
				loadGraphic(Paths.item('pizza'));
			case Feastable:
				loadGraphic(Paths.item('feastable'));
		}
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	public function getType():PizzaType
	{
		if (FlxG.save.data.speedMode)
			return Feastable;
		return Default;
	}
}

enum PizzaType
{
	Default;
	Feastable;
}