package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class WhatState extends FlxState
{
    var imageA:FlxSprite;

    override public function create()
    {
    	super.create();

        imageA = new FlxSprite();
        imageA.loadGraphic(Paths.image('rise'));
        imageA.alpha = 0;
        add(imageA);

        FlxG.sound.playMusic(Paths.music('creepy-old-computer'), 1, true);

        FlxTween.tween(imageA, {alpha: 1}, 30);

        /*#if debug
        new FlxTimer().start(30, function(tmr:FlxTimer)
		{
            Sys.exit(0);
		});
        #end*/
    }

    override public function update(elapsed:Float)
    {
		#if debug
		if (FlxG.keys.anyJustPressed([ESCAPE, BACKSPACE]))
		{
			FlxG.switchState(new WarningState());
		}
		#end
    }
}