package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;

class Item extends FlxSprite
{
	public function new(x:Float = 0, y:Float = 0) 
	{
		super(x, y);
		loadGraphic("assets/images/items/cheese.png", false);
	}
}