package;

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

	public var backdrop:FlxBackdrop;

	var logoMaxAngle:Float = 20;

    override public function create()
    {
    	super.create();

        bg = new FlxSprite();
		bg.loadGraphic("assets/images/bg-misery.png");
		bg.screenCenter();
		add(bg);

		backdrop = new FlxBackdrop(Paths.image('checker'));
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

		FlxTween.tween(logo, {y: logo.y + 24}, 1.1, {ease: FlxEase.quadInOut, type: PINGPONG, startDelay: 0.1});
		FlxTween.tween(logoDemo, {y: logoDemo.y + 24}, 1.1, {ease: FlxEase.quadInOut, type: PINGPONG, startDelay: 0.1});
		FlxTween.tween(logoDemo, {angle: logoDemo.angle + (logoMaxAngle * 2)}, 1.1, {ease: FlxEase.quadInOut, type: PINGPONG, startDelay: 0.1});

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
        buttonText.text = 'PLAY MY GAME';
        buttonText.size = 32;
        buttonText.font = "Times New Roman";
        buttonText.x = button.x + (button.width / 2) - (buttonText.width / 2);
        buttonText.y = button.y + (button.height / 2) - (buttonText.height / 2);
        add(buttonText);

        instructText = new FlxText();
        instructText.text = 'instructions';
        instructText.size = 32;
        instructText.font = "Times New Roman";
        instructText.x = instruct.x + (instruct.width / 2) - (instructText.width / 2);
        instructText.y = instruct.y + (instruct.height / 2) - (instructText.height / 2);
        add(instructText);

		credText = new FlxText();
		credText.text = 'Credits';
		credText.size = 32;
		credText.font = "Times New Roman";
		credText.x = credButton.x + (credButton.width / 2) - (credText.width / 2);
		credText.y = credButton.y + (credButton.height / 2) - (credText.height / 2);
		add(credText);

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
        credits.font = "Times New Roman";
        credits.size = 24;
        credits.x = 12;
        credits.y = FlxG.height - credits.height - 12;
        add(credits);

		FlxG.sound.playMusic(Paths.music("mainmenu"), 1, true);
    }

    override public function update(elapsed:Float)
    {
    	super.update(elapsed);

		backdrop.velocity.x = 50;
		backdrop.velocity.y = 50;

		if (FlxG.keys.justPressed.SIX && FlxG.save.data.speedUnlocked && FlxG.save.data.speedMode)
		{
			FlxG.save.data.speedMode = false;

			var routeText:FlxText = new FlxText();
			routeText.text = "Speed Mode disabled";
			routeText.setFormat("Times New Roman", 40, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			routeText.screenCenter(X);
			routeText.y = 12;
			routeText.alpha = 0;
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
                FlxTween.tween(e, {alpha: 0.6}, 0.6);
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
                    FlxTween.tween(e, {alpha: 1}, 0.6);
                }
            }
        }

        if (FlxG.mouse.overlaps(instruct))
        {
            for (e in [instruct, instructText])
            {
                FlxTween.tween(e, {alpha: 0.6}, 0.6);
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
                    FlxTween.tween(e, {alpha: 1}, 0.6);
                }
            }
        }
		if (FlxG.mouse.overlaps(credButton))
		{
			for (e in [credButton, credText])
			{
				FlxTween.tween(e, {alpha: 0.6}, 0.6);
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
					FlxTween.tween(e, {alpha: 1}, 0.6);
				}
			}
		}
    }
}