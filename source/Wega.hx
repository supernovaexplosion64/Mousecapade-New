package;

import flixel.FlxG;
import flixel.FlxSprite;

class Wega extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);
        loadGraphic("assets/images/enemies/wega.png");
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
        updateHitbox();
	}
}