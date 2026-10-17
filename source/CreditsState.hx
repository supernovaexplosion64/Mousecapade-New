package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class CreditsState extends FlxState
{
	public var camMain:FlxCamera;
	public var camBack:FlxCamera;
	public var thatOneCameraThatWasSolelyMadeForTheExitButtonForSomeReason:FlxCamera;
    public var credText:FlxText;
	public var credText2:FlxText;
	public var credText3:FlxText;
	public var playtestText:FlxText;
    public var specialText:FlxText;
	public var bg:FlxSprite;
	public var backdrop:FlxBackdrop;
	public var credIcon:FlxSprite;
	public var credIcon2:FlxSprite;
	public var credIcon3:FlxSprite;

    public var exit:FlxSprite;
    public var exitText:FlxText;

	public var playtesters:Array<String> = ['Tapey_7778', 'NatsukiFan98', 'Layer09', 'JoaquinCualquiera123'];
	public var specialThanks:Array<String> = [
		'Developers of Vs. Mouse',
		'Drunk Rat Studios',
		'Rookies Team',
		'Developers of Vs. Mouse: Cheesed Up',
		'The Ancient Mice Dev Team',
		'NatuskiFan98 (for letting me use the OMG image)',
		'Battle for Dream Island',
		'Dillon Howland',
		'sammieGHA',
		'IShowerSpeed',
		'Five Nights at Treasure Island'
	];

	var credTextDev:FlxText = new FlxText(0, 0, 0, "Developers", 48);
	var credTextCon:FlxText = new FlxText(0, 0, 0, "Contributors", 48);
	var credTextPlay:FlxText = new FlxText(0, 0, 0, "Playtesters", 48);
	var credTextThanks:FlxText = new FlxText(0, 0, 0, "Special Thanks", 48);
	var credTextDesc1:FlxText = new FlxText(0, 0, 0, "supernovaexplosion64", 40);
	var credTextDesc2:FlxText = new FlxText(0, 0, 0, "sammieGHA", 40);
	var credTextDesc3:FlxText = new FlxText(0, 0, 0, "Layer09", 40);

	var maxCameraPos:Int = Std.int(FlxG.height * 3);

	override public function create()
    {
    	super.create();

		// REMINDER TO CODE ALL OF THIS IN A BETTER WAY IN THE FULL GAME

		camBack = new FlxCamera();
		camBack.bgColor.alpha = 0;
		FlxG.cameras.add(camBack, false);

		camMain = new FlxCamera(0, 0, FlxG.width, maxCameraPos);
		camMain.bgColor.alpha = 0;
		FlxG.cameras.add(camMain, true);

		thatOneCameraThatWasSolelyMadeForTheExitButtonForSomeReason = new FlxCamera();
		thatOneCameraThatWasSolelyMadeForTheExitButtonForSomeReason.bgColor.alpha = 0;
		FlxG.cameras.add(thatOneCameraThatWasSolelyMadeForTheExitButtonForSomeReason, false);

		bg = new FlxSprite();
		bg.loadGraphic(Paths.image("bg-misery"));
		// bg.alpha = 0;
		bg.screenCenter();
		bg.cameras = [camBack];
		bg.scrollFactor.set(0, 0);
		add(bg);

		backdrop = new FlxBackdrop(Paths.image("menu/credit-backdrop"));
		backdrop.alpha = 0.5;
		backdrop.velocity.x = 50;
		backdrop.velocity.y = 50;
		backdrop.scrollFactor.set();
		backdrop.cameras = [camBack];
		add(backdrop);

		credIcon = new FlxSprite();
		credIcon.loadGraphic(Paths.image("credits/rico"));
		credIcon.setGraphicSize(256, 256);
		credIcon.updateHitbox();
		credIcon.x = 12;
		credIcon.y = 60;
		add(credIcon);

		credIcon2 = new FlxSprite();
		credIcon2.loadGraphic(Paths.image("credits/sammie"));
		credIcon2.setGraphicSize(256, 256);
		credIcon2.updateHitbox();
		credIcon2.x = 12;
		credIcon2.y = credIcon.y + (credIcon.height * 1.5);
		add(credIcon2);

		credIcon3 = new FlxSprite();
		credIcon3.loadGraphic(Paths.image("credits/layer"));
		credIcon3.setGraphicSize(256, 256);
		credIcon3.updateHitbox();
		credIcon3.x = 12;
		credIcon3.y = credIcon2.y + credIcon2.height + 12;
		add(credIcon3);

		credTextDev.setFormat("Times New Roman", 48, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		credTextDev.antialiasing = true;
		credTextDev.screenCenter(X);
		add(credTextDev);

		credTextCon.setFormat("Times New Roman", 48, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		credTextCon.antialiasing = true;
		credTextCon.screenCenter(X);
		credTextCon.y = credIcon.y + credIcon.height + 12;
		add(credTextCon);

		credTextPlay.setFormat("Times New Roman", 48, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		credTextPlay.antialiasing = true;
		credTextPlay.screenCenter(X);
		credTextPlay.y = credIcon3.y + credIcon3.height + 12;
		add(credTextPlay);

		credTextDesc1.x = credIcon.x + credIcon.width + 12;
		credTextDesc1.y = credIcon.y;
		credTextDesc1.setFormat("Times New Roman", 40, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		credTextDesc1.antialiasing = true;
		add(credTextDesc1);

		credTextDesc2.x = credIcon2.x + credIcon2.width + 12;
		credTextDesc2.y = credIcon2.y;
		credTextDesc2.setFormat("Times New Roman", 40, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		credTextDesc2.antialiasing = true;
		add(credTextDesc2);

		credTextDesc3.x = credIcon3.x + credIcon3.width + 12;
		credTextDesc3.y = credIcon3.y;
		credTextDesc3.setFormat("Times New Roman", 40, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		credTextDesc3.antialiasing = true;
		add(credTextDesc3);

        credText = new FlxText();
		credText.text = 'Creator\nMain developer\nMain programmer\nMain composer';
		if (FlxG.random.bool(1))
			credText.text += "\nThe idiot loser who thought of the idea of this game";
		credText.setFormat("Times New Roman", 30, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		credText.antialiasing = true;
		credText.x = credIcon.x + credIcon.width + 12;
		credText.y = credTextDesc1.y + credTextDesc1.height + 12;
        add(credText);
		credText2 = new FlxText();
		credText2.text = 'Helped with some of the code';
		credText2.setFormat("Times New Roman", 30, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		credText2.antialiasing = true;
		credText2.x = credIcon2.x + credIcon2.width + 12;
		credText2.y = credTextDesc2.y + credTextDesc2.height + 12;
		add(credText2);
		credText3 = new FlxText();
		credText3.text = 'Composed the credits menu and game over theme';
		credText3.setFormat("Times New Roman", 30, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		credText3.antialiasing = true;
		credText3.x = credIcon3.x + credIcon3.width + 12;
		credText3.y = credTextDesc3.y + credTextDesc3.height + 12;
		add(credText3);
		playtestText = new FlxText(0, 0, FlxG.width);
		playtestText.text = '';
		for (i in 0...playtesters.length)
		{
			if (i == 0)
				playtestText.text += playtesters[i];
			else
				playtestText.text += '\n' + playtesters[i];
		}
		playtestText.antialiasing = true;
		playtestText.setFormat("Times New Roman", 36, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		playtestText.screenCenter(X);
		playtestText.y = credTextPlay.y + credTextPlay.height + 12;
		add(playtestText);

		credTextThanks.setFormat("Times New Roman", 48, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		credTextThanks.antialiasing = true;
		credTextThanks.screenCenter(X);
		credTextThanks.y = playtestText.y + playtestText.height + 12;
		add(credTextThanks);

		specialText = new FlxText(0, 0, FlxG.width);
		specialText.text = '';
		for (i in 0...specialThanks.length)
		{
			if (i == 0)
				specialText.text += specialThanks[i];
			else
				specialText.text += '\n' + specialThanks[i];
		}
		if (FlxG.random.bool(10))
		{
			specialText.text += '\nYour mom lol';
		}
		specialText.antialiasing = true;
		specialText.setFormat("Times New Roman", 36, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		specialText.screenCenter(X);
		specialText.y = credTextThanks.y + credTextThanks.height + 12;
		add(specialText);

        exit = new FlxSprite();
        exit.makeGraphic(72, 72, FlxColor.RED);
        exit.x = FlxG.width - exit.width - 12;
		exit.y = FlxG.height - exit.height - 12;
		exit.cameras = [thatOneCameraThatWasSolelyMadeForTheExitButtonForSomeReason];
        add(exit);

        exitText = new FlxText();
        exitText.text = 'EXIT';
		exitText.setFormat("Times New Roman", 18, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        exitText.x = exit.x + (exit.width / 2) - (exitText.width / 2);
        exitText.y = exit.y + (exit.height / 2) - (exitText.height / 2);
		exitText.cameras = [thatOneCameraThatWasSolelyMadeForTheExitButtonForSomeReason];
        add(exitText);
		for (e in [
			credIcon,
			credIcon2,
			credIcon3,
			credTextDev,
			credTextCon,
			credTextPlay,
			credTextThanks,
			credTextDesc1,
			credTextDesc2,
			credTextDesc3,
			credText,
			credText2,
			credText3,
			playtestText,
			specialText
		])
		{
			e.cameras = [camMain];
		}
		var notice:FlxText = new FlxText(0, 0, FlxG.width - (credTextDev.x + credTextDev.width),
			"Press the arrow keys on your keyboard to scroll up or down!\nClick on the icons to see the person's social page!");
		notice.setFormat("Times New Roman", 24, FlxColor.WHITE, FlxTextAlign.RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.GRAY);
		notice.alpha = 0.6;
		notice.antialiasing = true;
		notice.x = FlxG.width - notice.width - 12;
		notice.y = 12;
		notice.cameras = [thatOneCameraThatWasSolelyMadeForTheExitButtonForSomeReason];
		add(notice);
		// FlxG.watch.add(camMain, "y");
		FlxG.sound.playMusic(Paths.music("credits"), 1, true);
		// FlxG.worldBounds.set(0, 0, FlxG.width, FlxG.height * 3);
    }

    override public function update(elapsed:Float):Void
	{
		if (camMain.y <= 0 && camMain.y >= maxCameraPos * -1)
		{
			if (FlxG.keys.anyPressed([W, UP]))
			{
				camMain.y += 360 * FlxG.elapsed;
			}
			if (FlxG.keys.anyPressed([S, DOWN]))
			{
				camMain.y -= 360 * FlxG.elapsed;
			}
		}

		if (camMain.y > 0)
			camMain.y = 0;
		if (camMain.y < maxCameraPos * -1)
			camMain.y = maxCameraPos * -1;

		for (e in [credIcon, credIcon2, credIcon3])
		{
			e.updateHitbox();
		}

        if (FlxG.mouse.overlaps(exit))
        {
            for (e in [exit, exitText])
            {
				FlxTween.tween(e, {alpha: 0.6}, e.alpha - 0.6);
            }

            if (FlxG.mouse.justPressed)
            {
                FlxG.switchState(new MainMenuState());
            }
        }
		else
		{
			if (exit.alpha < 1)
			{
				for (e in [exit, exitText])
				{
					FlxTween.tween(e, {alpha: 1}, 1 - e.alpha);
				}
			}
		}

		if (FlxG.mouse.overlaps(credIcon, camMain))
		{
			if (FlxG.mouse.justPressed)
			{
				FlxG.openURL("https://www.youtube.com/@SuperNovaExplosion64");
			}
		}

		if (FlxG.mouse.overlaps(credIcon2, camMain))
		{
			if (FlxG.mouse.justPressed)
			{
				FlxG.openURL("https://x.com/defokobreasts");
			}
		}
		if (FlxG.mouse.overlaps(credIcon3, camMain))
		{
			if (FlxG.mouse.justPressed)
			{
				FlxG.openURL("https://www.youtube.com/channel/UCATxC1MqK60fdBZ0R8pycGw");
			}
		}
		if (FlxG.keys.anyJustPressed([ESCAPE, BACKSPACE]))
		{
			FlxG.switchState(new MainMenuState());
		}
    	super.update(elapsed);
    }
}