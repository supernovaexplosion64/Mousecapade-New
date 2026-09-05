package;

import flixel.FlxG;
import flixel.FlxSprite;

class Pizza extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);
		loadGraphic(Paths.item('pizza'));
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}