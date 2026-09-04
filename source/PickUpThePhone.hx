package;

import flixel.FlxG;
import flixel.FlxSprite;

class PickUpThePhone extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);
        loadGraphic("assets/images/enemies/fnati.png");
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
        updateHitbox();
	}
}