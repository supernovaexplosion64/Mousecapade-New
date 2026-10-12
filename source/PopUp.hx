package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.sound.FlxSound;

class PopUp extends FlxSprite
{
    public var popUp:FlxSprite;
	public var playSound:FlxSound;

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
		'alpha',
		'ost',
		'dead'
	];

	var popUpsSpeed:Array<String> = ['ksi', 'bambi'];

	public function new()
	{
		super();

		loadGraphic(Paths.image('popups/placeholder'), false);
		if (width != FlxG.width || height != FlxG.height)
			setGraphicSize(FlxG.width, FlxG.height);
		screenCenter();
		alpha = 0.6;
	}

	public function getPopUp(type:PopUpType)
	{
		if (type == Normal)
		{
			var popUpNums:Int = popUps.length;
			var pathString:String = 'popups/${popUps[FlxG.random.int(0, popUpNums - 1)]}';
			playSound = FlxG.sound.load(Paths.sound("mickey-mouse"));
			if (FlxG.save.data.speedMode)
			{
				playSound = FlxG.sound.load(Paths.sound("bark"));
				popUpNums = popUpsSpeed.length;
				pathString = 'popups/speed/${popUpsSpeed[FlxG.random.int(0, popUpNums - 1)]}';
			}
			loadGraphic(Paths.image(pathString));
			playSound.play();
		}
		else if (type == Wega)
		{
			loadGraphic(Paths.image('popups/scream'));
			if (FlxG.save.data.screenShaking)
				FlxG.camera.shake(0.03, 0.3);
			playSound = FlxG.sound.load(Paths.sound("scream"));
			playSound.play();
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