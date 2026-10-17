package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class TitleState extends FlxState
{
	public var randomString:Array<String> = [
        "THIS IS",
        "hello boy",
        "Hi",
		"Hi",
		"Hi",
        "His name isn't IShowSpeed",
		"erm",
		"Dave and Bambi is a good FNF mod",
		"Battle for Dream Island is a good show",
		"Not affiliated with",
		"Kill all",
		"Obey Weegee",
		"Hello my baby hello my honey",
		"Is that a",
		"Warning:",
		"Nintendo is epic",
		"Who's the mouse with the plan that's gonna cook\nyou like a frying pan",
		"You know",
		"New niche meme:",
		"Feed me",
		"This isn't a"
    ];

	public var randomString2:Array<String> = [
        "JOSE JUAN",
		"what are you doing here",
        "Ruvim",
		"Mib",
		"Tapey",
        "GET IT RIGHT",
		"what the sigma",
		"Fight me TikTok",
		"Fight me Twitter",
		"Vs. Mouse",
		"Friday Night Funkin' fans",
		"Destroy Mario",
		"Hello my ragtime gal",
		"Chimptopia reference",
		"Friday Night Funkin' is in this game",
		"PC sucks",
		"\nM-I-C-K-E-Y\nM-O-U-S-E",
		"I like chilling out",
		"",
		"",
		"Friday Night Funkin' mod"
    ];

    public var initialThing:FlxText;
    public var thing2:FlxText;
    public var thing3:FlxText;
    public var thingFinal:FlxText;
    public var musicBPM:Float = 167;
    public var curBeat:Int = 0;
	public static var initialized:Bool = false;
    
    override public function create():Void
    {
    	super.create();

        initialThing = new FlxText();
        initialThing.text = '';
        initialThing.setFormat("Times New Roman", 64, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		initialThing.antialiasing = true;
        initialThing.screenCenter(X);
        initialThing.y = 200;
        add(initialThing);

        thing2 = new FlxText();
        thing2.text = '';
        thing2.setFormat("Times New Roman", 64, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		thing2.antialiasing = true;
        thing2.screenCenter(X);
        thing2.y = 200;
        add(thing2);

        thing3 = new FlxText();
        thing3.text = '';
        thing3.setFormat("Times New Roman", 64, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		thing3.antialiasing = true;
        thing3.screenCenter(X);
        thing3.y = 200;
        add(thing3);

        thingFinal = new FlxText();
        thingFinal.text = '';
        thingFinal.setFormat("Times New Roman", 64, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		thingFinal.antialiasing = true;
        thingFinal.screenCenter(X);
        thingFinal.y = 200;
        add(thingFinal);

        new FlxTimer().start(1, function(tmr:FlxTimer) // I'M SLENDERMAN, FIND MY NESTED FLXTIMERS
        {
			if (initialized)
			{
				FlxG.sound.playMusic(Paths.music("title-theme"), 1, true);
			}
			else
			{
				FlxG.sound.playMusic(Paths.music("title-theme"), 0, true);
				FlxG.sound.music.fadeIn((60 / musicBPM) * 32, 0, 1);
			}

            var randomNumber:Int = FlxG.random.int(0, randomString.length - 1);

            // TOBY FOX ASS CODE (I PROMISE I'LL MAKE BETTER CODE SOON)
            for (i in 0...32)
            {
                new FlxTimer().start((60/musicBPM) * i, function(tmr:FlxTimer)
                {
                    switch (i){
                        case 0:
                            initialThing.text += 'A game developed by';
                            updateTextStuff(initialThing);
                        case 4:
                            initialThing.text += '\nsupernovaexplosion64';
                            initialThing.text += '\n(with the help of others!)';
                            updateTextStuff(initialThing);
                        case 6:
                            initialThing.kill();
                        case 8:
                            thing2.text += 'Based on';
                            updateTextStuff(thing2);
                        case 10:
                            thing2.text += '\nVs. Mouse';
                            updateTextStuff(thing2);
                        case 12:
                            thing2.text += '\n(and other media)';
                            updateTextStuff(thing2);
                        case 14:
                            thing2.kill();
                        case 16:
                            thing3.text += randomString[randomNumber];
                            updateTextStuff(thing3);
                        case 20:
                            thing3.text += '\n' + randomString2[randomNumber];
                            updateTextStuff(thing3);
                        case 22:
                            thing3.kill();
                        case 24:
                            thingFinal.text += 'untitled';
                            updateTextStuff(thingFinal);
                        case 26:
                            thingFinal.text += '\nmarkus';
                            updateTextStuff(thingFinal);
                        case 28:
                            thingFinal.text += '\ngame';
                            updateTextStuff(thingFinal);
                        case 30:
                            thingFinal.text += '\nDEMO';
                            updateTextStuff(thingFinal);
                        case 32:
                            thingFinal.kill();
                    }
                });
            }

			if (randomNumber == 2)
			{
				new FlxTimer().start((60 / musicBPM * 20), function(tmr:FlxTimer)
				{
					var ruvim:FlxSprite;
					ruvim = new FlxSprite();
					ruvim.loadGraphic(Paths.image('menu/ruvim'));
					ruvim.setGraphicSize(256, 256);
					ruvim.updateHitbox();
					ruvim.screenCenter(X);
					ruvim.y = thing3.y + 152;
					add(ruvim);
					new FlxTimer().start((60 / musicBPM) * 2, function(tmr:FlxTimer)
					{
						ruvim.kill();
					});
				});
			}
			else if (randomNumber == 17 || randomNumber == 19)
			{
				new FlxTimer().start((60 / musicBPM * 20), function(tmr:FlxTimer)
				{
					var image:FlxSprite;
					image = new FlxSprite();
					if (randomNumber == 17)
						image.loadGraphic(Paths.image('menu/chilling'));
					else
						image.loadGraphic(Paths.image('player'));
					image.updateHitbox();
					image.screenCenter(X);
					image.y = thing3.y + 152;
					add(image);
					new FlxTimer().start((60 / musicBPM) * 2, function(tmr:FlxTimer)
					{
						image.kill();
					});
				});
			}

            new FlxTimer().start((60/musicBPM * 32), function(tmr:FlxTimer)
            {
                FlxG.switchState(new MainMenuState());
            });
        });
    }

    public function updateTextStuff(obj:FlxText)
    {
        obj.screenCenter(X);
        obj.y = 200;
        //obj.updateHitbox();
    }

    override public function update(elapsed:Float):Void
    {
		if (FlxG.keys.anyJustPressed([ENTER, SPACE]))
		{
			FlxG.switchState(new MainMenuState());
		}
        
    	super.update(elapsed);
    }
}