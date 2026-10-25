package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.sound.FlxSound;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class StartUpIntro extends FlxState
{
    var sprite:FlxSprite;
    var sound:FlxSound;

    var _cachedTimestep:Bool;
	var _cachedAutoPause:Bool;
	public var soundBPM:Float = 188;
	var stopAnim:Bool = false;

    override public function create():Void
    {
    	super.create();

        _cachedTimestep = FlxG.fixedTimestep;
		FlxG.fixedTimestep = false;

		_cachedAutoPause = FlxG.autoPause;
		FlxG.autoPause = false;

        sprite = new FlxSprite();
        sound = new FlxSound();
		if (FlxG.save.data.speedMode && FlxG.random.bool(10))
        {
            sprite.loadGraphic(Paths.image('intro/speed'), true, 256, 314);
            sprite.x = (FlxG.width / 2) - (256 / 2);
            sprite.y = (FlxG.height / 2) - (256 / 2);
			sprite.animation.add('play', [0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4], 24, false);
            //sprite.animation.play('play');
            add(sprite);
            sound = FlxG.sound.load(Paths.sound('intro/speed'), 1);
        }
        else
        {
            sprite.loadGraphic(Paths.image('intro/normal'), true, 256, 319);
            sprite.x = (FlxG.width / 2) - (256 / 2);
            sprite.y = (FlxG.height / 2) - (256 / 2);
			sprite.animation.add('play', [0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4], 24, false);
            //sprite.animation.play('play');
            add(sprite);
            sound = FlxG.sound.load(Paths.sound('intro/normal'), 1);
        }
		sound.play();
	}

	override public function update(elapsed:Float):Void
	{
		if (sound != null && !stopAnim)
		{
			stopAnim = true;
			startAnim();
		}
        if (FlxG.keys.anyJustPressed([ENTER, SPACE]))
        {
			switchDaState();
        }
    	super.update(elapsed);
    }
	function switchDaState()
	{
		if (FlxG.save.data.shakingUnderstood)
			FlxG.switchState(new TitleState());
		else
			FlxG.switchState(new WarningState());
	}
	function startAnim()
	{
		sprite.animation.play('play');

		FlxTween.tween(sprite, {alpha: 0}, 3, {startDelay: 0.63});

		if (FlxG.random.bool(30))
		{
			FlxTween.tween(sprite, {"scale.x": 5, "scale.y": 5, angle: 360 * 15}, 3, {ease: FlxEase.cubeIn, startDelay: 0.63});
		}

		var timer:FlxTimer = new FlxTimer();
		timer.start(5.1, function(tmr:FlxTimer)
		{
			switchDaState();
		});
	}
}