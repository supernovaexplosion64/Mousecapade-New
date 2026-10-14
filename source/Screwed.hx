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
	public var prefix:String = '';
    // make function that causes screen to break
	public function new(x:Float, y:Float)
	{
		super(x, y);
        switch getType()
		{
			case Normal:
				prefix = 'screwed/';
				daGraphic = 'normal';
                SPEED = 75;
				healthDecrease = 2;
				daScale = 0.9;
				daShake = 0.1;
				randomMulti = 1.2;
				alphaAlpha = 0.3;
			case Red:
				prefix = 'screwed/';
				daGraphic = 'red';
				SPEED = 125;
				healthDecrease = 5;
				daScale = 1.2;
				daShake = 0.175;
				randomMulti = 1.6;
				alphaAlpha = 0.5;
			case New:
				prefix = 'screwed/';
				daGraphic = 'new';
				SPEED = 150;
				healthDecrease = 10;
				daScale = 1.6;
				daShake = 0.2;
				randomMulti = 2;
				alphaAlpha = 0.8;
            case Angry:
				prefix = 'screwed/';
				daGraphic = 'angry';
				SPEED = 200;
				healthDecrease = 25;
				daScale = 2.2;
				daShake = 0.3;
				randomMulti = 2.5;
				alphaAlpha = 1;
			case Ksi:
				daGraphic = 'ksi';
				SPEED = 100;
				healthDecrease = 7;
				daScale = 1.4;
				daShake = 0.18;
				randomMulti = 1.8;
				alphaAlpha = 0.6;
		}
		loadGraphic(Paths.enemy('${prefix}' + '${daGraphic}'), false);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
        updateHitbox();
	}

    public function getType():ScrewedType
    {
		if (FlxG.save.data.speedMode)
			return Ksi;
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
	Ksi;
}