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
	var dateText:FlxText;
	var quoteText:FlxText;

	var quotes:Array<String> = [
		"he knew how to beatbox real good",
		"he knew how to rap battle real good",
		"he was the mickey to my mousecapade",
		"he thought welcome old was a good song",
		"hi ruvim",
		"his favorite Baldi mod was Dave's Fun Algebra Class",
		"play Talking Ben again",
		"https://youtu.be/1L8PirvL7K0",
		"Crisis V3 - Vs. Mouse Ultimate OST",
		"What kind of person names their game 'untitled markus game'? Is everyone THAT unoriginal now?",
		"StanleyMOV ain't got nothing on this dude!",
		"My IShowers have been Speeded",
		"HIS NAME IS ISHOWERSPEED NOT ISHOWSPEED",
		"Pick up the phone",
		"Back in my day, FNF modding was purely hardcoded!"
	];

    override public function create()
    {
    	super.create();

		FlxG.sound.playMusic(Paths.music('secret'), 1, true);

        var currentDateMonth = DateTools.format(Date.now(), "%B");
	    var currentDateDay = DateTools.format(Date.now(), "%d");
	    var currentDateYear = DateTools.format(Date.now(), "%Y");

        imageA = new FlxSprite();
		imageA.loadGraphic(Paths.image('speed-monochrome'));
		imageA.screenCenter();
        imageA.alpha = 0;
        add(imageA);

		ripText = new FlxText();
		ripText.text = 'rest in peace IShowerSpeed';
		ripText.font = "Times New Roman";
		ripText.antialiasing = true;
        ripText.size = 48;
		ripText.screenCenter(X);
		ripText.y = imageA.y - ripText.height - 12;
		ripText.alpha = 0;
        add(ripText);

		dateText = new FlxText();
		dateText.text = 'January 21, 2005 - \n' + currentDateMonth + ' ' + currentDateDay + ', ' + currentDateYear;
		dateText.font = "Times New Roman";
		dateText.antialiasing = true;
		dateText.size = 32;
		dateText.screenCenter(X);
		dateText.y = imageA.y + imageA.height + 12;
		dateText.alpha = 0;
		add(dateText);

		var quoteNums:Int = quotes.length;

		quoteText = new FlxText();
		quoteText.text = '"' + quotes[FlxG.random.int(0, quoteNums - 1)] + '"';
		quoteText.font = "Times New Roman";
		quoteText.antialiasing = true;
		quoteText.size = 40;
		quoteText.screenCenter(X);
		quoteText.y = dateText.y + dateText.height + 12;
		quoteText.alpha = 0;
		add(quoteText);

        //FlxG.sound.playMusic(Paths.music('creepy-old-computer'), 1, true);

		FlxTween.tween(imageA, {alpha: 1}, 3.5, {startDelay: 3.5});
		FlxTween.tween(ripText, {alpha: 1}, 3.5, {startDelay: 7});
		FlxTween.tween(dateText, {alpha: 1}, 3.5, {startDelay: 10.5});
		FlxTween.tween(quoteText, {alpha: 1}, 3.5, {startDelay: 14});
    }

    override public function update(elapsed:Float)
    {
		if (FlxG.keys.anyJustPressed([ESCAPE, BACKSPACE]))
		{
			FlxG.switchState(new MainMenuState());
		}
    }
}