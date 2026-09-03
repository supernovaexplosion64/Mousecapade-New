package;

import flixel.FlxG;
import flixel.FlxSprite;

class Screwed extends FlxSprite
{
    public var healthDecrease:Int;

	public var SPEED:Float = 0;
	public var daGraphic:String;
	public var daScale:Float;
	public var daShake:Float;
	public var randomMulti:Float;
	public var alphaAlpha:Float;
    // make function that causes screen to break
	public function new(x:Float, y:Float)
	{
		super(x, y);
        switch getType()
		{
			case Normal:
				daGraphic = 'normal';
                SPEED = 75;
				healthDecrease = 3;
				daScale = 0.9;
				daShake = 0.1;
				randomMulti = 1.2;
				alphaAlpha = 0.3;
			case Red:
				daGraphic = 'red';
				SPEED = 125;
				healthDecrease = 15;
				daScale = 1.2;
				daShake = 0.175;
				randomMulti = 1.6;
				alphaAlpha = 0.5;
			case New:
				daGraphic = 'new';
				SPEED = 150;
				healthDecrease = 25;
				daScale = 1.6;
				daShake = 0.2;
				randomMulti = 2;
				alphaAlpha = 0.8;
            case Angry:
				daGraphic = 'angry';
				SPEED = 200;
				healthDecrease = 55;
				daScale = 2.2;
				daShake = 0.3;
				randomMulti = 2.5;
				alphaAlpha = 1;
		}
		loadGraphic(Paths.enemy('screwed/${daGraphic}'), false);
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