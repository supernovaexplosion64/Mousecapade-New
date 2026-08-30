package;

import flixel.FlxG;
import flixel.FlxSprite;

class Screwed extends FlxSprite
{
    public var healthDecrease:Int;

	public var SPEED:Float = 0;
    // make function that causes screen to break
	public function new(x:Float, y:Float)
	{
		super(x, y);
        switch getType()
		{
			case Normal:
				loadGraphic(Paths.enemy('screwed/normal'), false);
                SPEED = 75;
				healthDecrease = 3;
			case Red:
				loadGraphic(Paths.enemy('screwed/red'), false);
				SPEED = 125;
				healthDecrease = 15;
			case New:
				loadGraphic(Paths.enemy('screwed/new'), false);
				SPEED = 150;
				healthDecrease = 25;
            case Angry:
                loadGraphic(Paths.enemy('screwed/angry'), false);
				SPEED = 200;
				healthDecrease = 55;
		}
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
        updateHitbox();
	}

    public function getType():ScrewedType
    {
        var rng:Int = FlxG.random.int(1, 50);

        if (rng <= 1)
            return Angry;
        if (rng <= 6)
            return New;
        if (rng <= 16)
            return Red;
        return Normal;
    }
}

enum ScrewedType
{
    Normal;
    Red;
    Angry;
    New;
}