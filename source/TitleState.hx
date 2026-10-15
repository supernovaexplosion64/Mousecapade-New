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
		"bfdi is a good show",
        "THIS IS",
        "hello boy",
        "Hi",
        "His name isn't IShowSpeed",
        "erm"
    ];

    public var randomString2:Array<String> = [
		"please don't kill me",
        "JOSE JUAN",
        "please shut up",
        "Ruvim",
        "GET IT RIGHT",
        "what the sigma"
    ];

    public var initialThing:FlxText;
    public var thing2:FlxText;
    public var thing3:FlxText;
    public var thingFinal:FlxText;
    public var musicBPM:Float = 167;
    public var curBeat:Int = 0;
    override public function create():Void
    {
    	super.create();

        initialThing = new FlxText();
        initialThing.text = '';
        initialThing.setFormat("Times New Roman", 64, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        initialThing.screenCenter(X);
        initialThing.y = 200;
        add(initialThing);

        thing2 = new FlxText();
        thing2.text = '';
        thing2.setFormat("Times New Roman", 64, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        thing2.screenCenter(X);
        thing2.y = 200;
        add(thing2);

        thing3 = new FlxText();
        thing3.text = '';
        thing3.setFormat("Times New Roman", 64, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        thing3.screenCenter(X);
        thing3.y = 200;
        add(thing3);

        thingFinal = new FlxText();
        thingFinal.text = '';
        thingFinal.setFormat("Times New Roman", 64, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        thingFinal.screenCenter(X);
        thingFinal.y = 200;
        add(thingFinal);

        new FlxTimer().start(1, function(tmr:FlxTimer) // I'M SLENDERMAN, FIND MY NESTED FLXTIMERS
        {
            FlxG.sound.playMusic(Paths.music("title-theme"), 1, true);

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
    	super.update(elapsed);
    }
}