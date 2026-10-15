package;

import flixel.FlxG;
import flixel.FlxSprite;

class PickUpThePhone extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);
		switch (getType())
		{
			case Default:
				loadGraphic("assets/images/enemies/fnati.png");
			case John:
				loadGraphic("assets/images/enemies/john-pork.png");
		}
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
        updateHitbox();
	}
	public function getType():PhoneType
	{
		if (FlxG.save.data.speedMode)
			return John;
		return Default;
	}
}

enum PhoneType
{
	Default;
	John;
}