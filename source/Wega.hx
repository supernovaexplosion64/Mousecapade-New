package;

import flixel.FlxG;
import flixel.FlxSprite;

class Wega extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);
		loadGraphic(Paths.enemy("wega"));
		switch getType()
		{
			case Default:
				loadGraphic(Paths.enemy("wega"));
			case Ninja:
				loadGraphic(Paths.enemy("ninja"));
		}
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
        updateHitbox();
	}
	public function getType():EnemyType
	{
		if (FlxG.save.data.speedMode)
			return Ninja;
		return Default;
	}
}

enum EnemyType
{
	Default;
	Ninja;
}