package;

import Date;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

using DateTools;

class SecretDeathState extends FlxState
{
    var imageA:FlxSprite;
    var ripText:FlxText;

    override public function create()
    {
    	super.create();

        var currentDateMonth = DateTools.format(Date.now(), "%B");
	    var currentDateDay = DateTools.format(Date.now(), "%d");
	    var currentDateYear = DateTools.format(Date.now(), "%Y");

        imageA = new FlxSprite();
        imageA.loadGraphic(Paths.image('speed'));
        imageA.screenCenter(X);
        imageA.alpha = 0;
        add(imageA);

        ripText = new FlxText();
        ripText.text = 'Rest in Peace IShowerSpeed\nJanuary 21, 2005 - ' + currentDateMonth + ' ' + currentDateDay + ', ' + currentDateYear;
        //ripText.font = Paths.font('comic.ttf');
        ripText.size = 48;
        ripText.screenCenter();
        ripText.y -= 200;
        //ripText.alpha = 0;
        add(ripText);

        //FlxG.sound.playMusic(Paths.music('creepy-old-computer'), 1, true);

        FlxTween.tween(imageA, {alpha: 1}, 2);
    }

    override public function update(elapsed:Float)
    {
    }
}