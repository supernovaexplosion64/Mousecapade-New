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

		loadGraphic("assets/images/popups/placeholder.png");
        if (width != 1280 || height != 720)
            setGraphicSize(1280, 720);
		screenCenter();
		alpha = 0.6;
	}

	public function getPopUp(type:PopUpType)
	{
		if (type == Normal)
		{
			var popUpNums:Int = popUps.length;
			loadGraphic('assets/images/popups/${popUps[FlxG.random.int(0, popUpNums - 1)]}');
		}
		else if (type == Wega)
		{
			loadGraphic("assets/images/popups/scream.png");
			FlxG.camera.shake(0.03, 0.3);
		}
    }

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
enum PopUpType
{
	Normal;
	Wega;
}