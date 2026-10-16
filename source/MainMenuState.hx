package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.effects.FlxTrail;
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class MainMenuState extends FlxState
{
	public var logo:FlxSprite;
	public var logoDemo:FlxSprite;
	public var trail:FlxTrail;
    public var button:FlxSprite;
    public var instruct:FlxSprite;
    public var buttonText:FlxText;
    public var instructText:FlxText;

    public var bg:FlxSprite;

    
    public var warning:FlxText;
    public var credits:FlxText;

	public var credButton:FlxSprite;
	public var credText:FlxText;

	public var noteText:FlxText;
	public var noteText2:FlxText;
	public var noteText3:FlxText;

	public var backdrop:FlxBackdrop;

	var logoMaxAngle:Float = 20;

	var randomPopUpNotes:Array<String> = [
		"hello boy what are you doing here",
		"you want to play but i don't it hurts",
		"go play vs. mouse ultimate",
		"go play vs. mouse extremely old",
		"go play vs. mouse rookies edition",
		"go play THE BLEEDING HOUR",
		"go play vs. mouse: cheesed up (when it releases)",
		"IShowerSpeed collab when?",
		"Better than Lobotomy Clicker",
		"It was all started with a mouse",
		"I'm gonna break my phone",
		"StanleyMOV would have a FEAST playing this game",
		"How it feels to play Bindu n' Dive on September 25, 2026, 8:36 AM EDT:",
		"This game is pure inside joke slop",
		"Vs. Mouse fans, assemble",
		"Yes the same guy who danced to that Jose Juan song created this game",
		"Bro copied Friday Night Funkin'",
		"White people be like: this game is fun and enjoyable",
		"Took bro two years to create a new semi-original HaxeFlixel game",
		"Vs. Mouse aura",
		"I love you Olimac31",
		"This game gave me a brain aneurysm",
		"Press the letter Q to turn flashing lights and screen shaking on or off!"
	];

	var popUpText:FlxText;
	public var camMain:FlxCamera;
	public var blackScreen:FlxSprite;
	public static var maiMaiMai:Bool = false;

    override public function create()
    {
    	super.create();

		camMain = new FlxCamera();
		camMain.bgColor.alpha = 0;
		FlxG.cameras.add(camMain, false);

		blackScreen = new FlxSprite();
		blackScreen.alpha = 0;
		blackScreen.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		if (FlxG.save.data.screenShaking)
			blackScreen.color = FlxColor.WHITE;
		blackScreen.scrollFactor.set(0, 0);
		blackScreen.alpha = 1;
		blackScreen.cameras = [camMain];
		add(blackScreen);
		FlxTween.tween(blackScreen, {alpha: 0}, 1);
		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			blackScreen.kill();
		});

        bg = new FlxSprite();
		bg.loadGraphic("assets/images/bg-misery.png");
		bg.screenCenter();
		add(bg);

		backdrop = new FlxBackdrop(Paths.image('checker'));
		backdrop.velocity.x = 50;
		backdrop.velocity.y = 50;
		add(backdrop);

		logo = new FlxSprite(Paths.image('menu/logo'));
		logo.x = -12;
		logo.y = -12;
		add(logo);

		logoDemo = new FlxSprite(Paths.image('menu/demo'));
		logoDemo.x = logo.x + (logo.width * 0.8);
		logoDemo.y = logo.y + (logo.height * 0.45);
		logoDemo.angle = logoMaxAngle * -1;

		trail = new FlxTrail(logo, Paths.image('menu/logo'), 8, 2, 0.6, 0.14);
		add(trail);

		add(logoDemo);

		FlxTween.tween(logo, {y: logo.y + 24}, 1.1, {ease: FlxEase.quadInOut, type: PINGPONG});
		FlxTween.tween(logoDemo, {y: logoDemo.y + 24}, 1.1, {ease: FlxEase.quadInOut, type: PINGPONG});
		FlxTween.tween(logoDemo, {angle: logoDemo.angle + (logoMaxAngle * 2)}, 1.1, {ease: FlxEase.quadInOut, type: PINGPONG});

        button = new FlxSprite();
        button.makeGraphic(400, 150, FlxColor.LIME);
		button.x = 12;
		button.y = 120;
        add(button);

        instruct = new FlxSprite();
        instruct.makeGraphic(400, 150, FlxColor.LIME);
		instruct.x = button.x;
        instruct.y = button.y + button.height + 12;
        add(instruct);

		credButton = new FlxSprite();
		credButton.makeGraphic(400, 150, FlxColor.LIME);
		credButton.x = button.x;
		credButton.y = instruct.y + instruct.height + 12;
		add(credButton);

        buttonText = new FlxText();
		buttonText.text = 'Play';
		buttonText.setFormat("Times New Roman", 32, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		buttonText.antialiasing = true;
		buttonText.x = button.x + (button.width / 2) - (buttonText.width / 2);
        buttonText.y = button.y + (button.height / 2) - (buttonText.height / 2);
        add(buttonText);

        instructText = new FlxText();
		instructText.text = 'Instructions';
		instructText.setFormat("Times New Roman", 32, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		instructText.antialiasing = true;
		instructText.x = instruct.x + (instruct.width / 2) - (instructText.width / 2);
        instructText.y = instruct.y + (instruct.height / 2) - (instructText.height / 2);
        add(instructText);

		credText = new FlxText();
		credText.text = 'Credits';
		credText.setFormat("Times New Roman", 32, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		credText.antialiasing = true;
		credText.x = credButton.x + (credButton.width / 2) - (credText.width / 2);
		credText.y = credButton.y + (credButton.height / 2) - (credText.height / 2);
		add(credText);

		var randomAngle:Float = FlxG.random.int(1, 15);
		var randomAngle2:Float = FlxG.random.int(1, 15);
		var randomAngle3:Float = FlxG.random.int(1, 15);

		noteText = new FlxText();
		noteText.text = 'Play the game!';
		noteText.setFormat("Times New Roman", 32, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		noteText.antialiasing = true;
		noteText.x = button.x + button.width + 24;
		noteText.y = button.y + (button.height / 2) - (noteText.height / 2);
		noteText.angle = randomAngle * -1;
		add(noteText);

		noteText2 = new FlxText();
		noteText2.text = 'Instructions of the game!';
		noteText2.setFormat("Times New Roman", 32, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		noteText2.antialiasing = true;
		noteText2.x = instruct.x + instruct.width + 24;
		noteText2.y = instruct.y + (instruct.height / 2) - (noteText2.height / 2);
		noteText2.angle = randomAngle2 * -1;
		add(noteText2);

		noteText3 = new FlxText();
		noteText3.text = 'People who worked on the game!';
		noteText3.setFormat("Times New Roman", 32, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		noteText3.antialiasing = true;
		noteText3.x = credButton.x + credButton.width + 24;
		noteText3.y = credButton.y + (credButton.height / 2) - (noteText3.height / 2);
		noteText3.angle = randomAngle3 * -1;
		add(noteText3);

		FlxTween.tween(noteText, {angle: noteText.angle + (randomAngle * 2)}, 1.1,
			{ease: FlxEase.quadInOut, type: PINGPONG, startDelay: FlxG.random.float(0, 0.6)});
		FlxTween.tween(noteText2, {angle: noteText2.angle + (randomAngle2 * 2)}, 1.1,
			{ease: FlxEase.quadInOut, type: PINGPONG, startDelay: FlxG.random.float(0, 0.6)});
		FlxTween.tween(noteText3, {angle: noteText3.angle + (randomAngle3 * 2)}, 1.1,
			{ease: FlxEase.quadInOut, type: PINGPONG, startDelay: FlxG.random.float(0, 0.6)});

        warning = new FlxText();
        warning.text = 'Please DO NOT play this game if you are a person with epilepsy and/or prone to seizures.';
        warning.fieldWidth = FlxG.width;
        warning.size = 36;
        warning.font = "Times New Roman";
        warning.screenCenter(X);
        warning.y = 500;
		// add(warning);

        credits = new FlxText();
		credits.text = 'Game created by Rico W./"supernovaexplosion64"';
		credits.setFormat("Times New Roman", 24, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		credits.antialiasing = true;
		credits.x = FlxG.width - credits.width - 12;
		credits.y = 12;
        add(credits);

		var randomPopUpLength = randomPopUpNotes.length;
		var randomPopUpAngle:Float = FlxG.random.int(1, 6);

		popUpText = new FlxText();
		popUpText.text = randomPopUpNotes[FlxG.random.int(0, randomPopUpLength - 1)];
		popUpText.setFormat("Times New Roman", 32, FlxColor.YELLOW, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, 0xFF808000);
		popUpText.antialiasing = true;
		popUpText.x = 12;
		popUpText.y = FlxG.height - popUpText.height - 12;
		popUpText.angle = randomPopUpAngle * -1;
		add(popUpText);

		FlxTween.tween(popUpText, {angle: popUpText.angle + (randomPopUpAngle * 2)}, 3.3, {ease: FlxEase.quadInOut, type: PINGPONG});
		if (TitleState.initialized)
			FlxG.sound.playMusic(Paths.music("title-theme"), 1, true);
		if (!TitleState.initialized)
			TitleState.initialized = true;
	}

    override public function update(elapsed:Float)
    {
    	super.update(elapsed);

		if (FlxG.keys.justPressed.SIX && FlxG.save.data.speedUnlocked && FlxG.save.data.speedMode)
		{
			FlxG.save.data.speedMode = false;

			var routeText:FlxText = new FlxText();
			routeText.text = "Speed Mode disabled";
			routeText.setFormat("Times New Roman", 40, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			routeText.antialiasing = true;
			routeText.screenCenter(X);
			routeText.y = 12;
			routeText.alpha = 0;
			add(routeText);

			FlxTween.tween(routeText, {alpha: 1}, 0.6);
			FlxTween.tween(routeText, {alpha: 0}, 1.8, {startDelay: 2.2});
		}

		if (FlxG.keys.justPressed.Q)
		{
			var routeText:FlxText = new FlxText();
			routeText.text = '';
			routeText.setFormat("Times New Roman", 40, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			routeText.antialiasing = true;
			routeText.alpha = 0;

			FlxG.save.data.screenShaking = !FlxG.save.data.screenShaking;

			if (FlxG.save.data.screenShaking)
			{
				routeText.text = 'Flashing lights and screen shaking enabled';
			}
			else
			{
				routeText.text = 'Flashing lights and screen shaking disabled';
			}
			routeText.screenCenter(X);
			routeText.y = 12;
			add(routeText);

			FlxTween.tween(routeText, {alpha: 1}, 0.6);
			FlxTween.tween(routeText, {alpha: 0}, 1.8, {startDelay: 2.2});
		}

		if (FlxG.keys.justPressed.SEVEN && FlxG.save.data.speedUnlocked && !FlxG.save.data.speedMode)
		{
			FlxG.save.data.speedMode = true;
			var weirdSoundJingle:FlxSound = new FlxSound();
			weirdSoundJingle = FlxG.sound.load(Paths.sound('weird-route-jingle'));
			weirdSoundJingle.play();

			var routeText:FlxText = new FlxText();
			routeText.text = "Speed Mode enabled";
			routeText.setFormat("Times New Roman", 40, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			routeText.antialiasing = true;
			routeText.screenCenter(X);
			routeText.y = routeText.height * -1;
			add(routeText);

			FlxTween.tween(routeText, {y: 12}, 0.6, {ease: FlxEase.backOut});
			FlxTween.tween(routeText, {alpha: 0}, 1.8, {startDelay: 2.2});
		}

        if (FlxG.mouse.overlaps(button))
        {
            for (e in [button, buttonText])
            {
				FlxTween.tween(e, {alpha: 0.6}, e.alpha - 0.6);
            }

            if (FlxG.mouse.justPressed)
            {
                FlxG.switchState(new PlayState());
            }
        }
        else
        {
            if (button.alpha < 1)
            {
                for (e in [button, buttonText])
                {
					FlxTween.tween(e, {alpha: 1}, 1 - e.alpha);
                }
            }
        }

        if (FlxG.mouse.overlaps(instruct))
        {
            for (e in [instruct, instructText])
            {
				FlxTween.tween(e, {alpha: 0.6}, e.alpha - 0.6);
            }

            if (FlxG.mouse.justPressed)
            {
                FlxG.switchState(new InstructionGuideState());
            }
        }
        else
        {
            if (instruct.alpha < 1)
            {
                for (e in [instruct, instructText])
                {
					FlxTween.tween(e, {alpha: 1}, 1 - e.alpha);
                }
            }
        }
		if (FlxG.mouse.overlaps(credButton))
		{
			for (e in [credButton, credText])
			{
				FlxTween.tween(e, {alpha: 0.6}, e.alpha - 0.6);
			}

			if (FlxG.mouse.justPressed)
			{
				FlxG.switchState(new CreditsState());
			}
		}
		else
		{
			if (credButton.alpha < 1)
			{
				for (e in [credButton, credText])
				{
					FlxTween.tween(e, {alpha: 1}, 1 - e.alpha);
				}
			}
		}
    }
}