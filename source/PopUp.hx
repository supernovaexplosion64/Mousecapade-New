package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;

class PopUp extends FlxSprite
{
    public var popUp:FlxSprite;
    var popUps:Array<String> =
    [
        'revenge',
        'quiddy',
        'feedme',
        'donald',
        'fat',
        'omg',
        'phone',
        'billy',
        'skinny',
        'madness',
        'alpha'
    ];

	public function new()
	{
		super();

        loadGraphic("assets/images/popups/" + getPopUp() + ".png");
        if (width != 1280 || height != 720)
            setGraphicSize(1280, 720);
		screenCenter();
	}

    function getPopUp():String
    {
        var popUpNums:Int = popUps.length;
        var getRandom:Int = FlxG.random.int(0, popUpNums - 1);
        return popUps[getRandom];
    }

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}