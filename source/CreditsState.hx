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
	public var thatOneCameraThatWasSolelyMadeForTheExitButtonForSomeReason:FlxCamera;
    public var credText:FlxText;
	public var credText2:FlxText;
    public var specialText:FlxText;
	public var bg:FlxSprite;
	public var backdrop:FlxBackdrop;
	public var credIcon:FlxSprite;
	public var credIcon2:FlxSprite;

    public var exit:FlxSprite;
    public var exitText:FlxText;

	public var playtesters:Array<String> = ['Place the holder'];
	public var specialThanks:Array<String> = [
		'Developers of Vs. Mouse',
		'Developers of Vs. Mouse ULTIMATE',
		'Developers of Vs. Mouse: Cheesed Up',
		'The Ancient Mice Dev Team',
		'Battle for Dream Island',
		'SammieGHA',
		'Your mom'
	];

	override public function create()
    {
    	super.create();

		camMain = new FlxCamera();
		camMain.bgColor.alpha = 0;
		FlxG.cameras.add(camMain, false);

		thatOneCameraThatWasSolelyMadeForTheExitButtonForSomeReason = new FlxCamera();
		thatOneCameraThatWasSolelyMadeForTheExitButtonForSomeReason.bgColor.alpha = 0;
		FlxG.cameras.add(thatOneCameraThatWasSolelyMadeForTheExitButtonForSomeReason, false);

		bg = new FlxSprite();
		bg.loadGraphic(Paths.image("bg-misery"));
		// bg.alpha = 0;
		bg.screenCenter();
		bg.scrollFactor.set(0, 0);
		add(bg);

		backdrop = new FlxBackdrop(Paths.image("menu/credit-backdrop"));
		backdrop.alpha = 0.5;
		backdrop.velocity.x = 50;
		backdrop.velocity.y = 50;
		backdrop.cameras = [camMain];
		add(backdrop);

		credIcon = new FlxSprite();
		credIcon.loadGraphic(Paths.image("credits/rico"));
		credIcon.setGraphicSize(256, 256);
		credIcon.updateHitbox();
		credIcon.x = 12;
		credIcon.y = 36;
		add(credIcon);

		credIcon2 = new FlxSprite();
		credIcon2.loadGraphic(Paths.image("credits/sammie"));
		credIcon2.setGraphicSize(256, 256);
		credIcon2.updateHitbox();
		credIcon2.x = 12;
		credIcon2.y = credIcon.y + (credIcon.height * 1.5);
		add(credIcon2);

		var credTextDev:FlxText = new FlxText(0, 0, 0, "Developers", 56);
		credTextDev.setFormat("Times New Roman", 56, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		credTextDev.antialiasing = true;
		credTextDev.screenCenter(X);
		add(credTextDev);

		var credTextCon:FlxText = new FlxText(0, 0, 0, "Contributors", 56);
		credTextCon.setFormat("Times New Roman", 56, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		credTextCon.antialiasing = true;
		credTextCon.screenCenter(X);
		credTextCon.y = credIcon.y + credIcon.height + 12;
		add(credTextCon);

		var credTextThanks:FlxText = new FlxText(0, 0, 0, "Special Thanks", 56);
		credTextThanks.setFormat("Times New Roman", 56, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		credTextThanks.antialiasing = true;
		credTextThanks.screenCenter(X);
		credTextThanks.y = credIcon2.y + credIcon2.height + 12;
		add(credTextThanks);

		var credTextDesc1:FlxText = new FlxText(credIcon.x + credIcon.width + 12, credIcon.y, 0, "supernovaexplosion64", 40);
		credTextDesc1.setFormat("Times New Roman", 48, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		credTextDesc1.antialiasing = true;
		add(credTextDesc1);

		var credTextDesc2:FlxText = new FlxText(credIcon2.x + credIcon2.width + 12, credIcon2.y, 0, "sammieGHA", 40);
		credTextDesc2.setFormat("Times New Roman", 48, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		credTextDesc2.antialiasing = true;
		add(credTextDesc2);

        credText = new FlxText();
		credText.text = 'Game creator\nMain developer\nComposer';
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
        
		specialText = new FlxText();
		specialText.text = "Special Thanks:";
		for (i in 0...specialThanks.length)
		{
			if (i == 0)
				specialText.text += specialThanks[i];
			else
				specialText.text += '\n' + specialThanks[i];
		}

		specialText.setFormat("Times New Roman", 36, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		specialText.screenCenter(X);
		specialText.y = credTextThanks.y + credTextThanks.height + 12;
		add(specialText);

        exit = new FlxSprite();
        exit.makeGraphic(72, 72, FlxColor.RED);
        exit.x = FlxG.width - exit.width - 12;
        exit.y = 12;
		exit.cameras = [thatOneCameraThatWasSolelyMadeForTheExitButtonForSomeReason];
        add(exit);

        exitText = new FlxText();
        exitText.text = 'EXIT';
        exitText.size = 18;
        exitText.x = exit.x + (exit.width / 2) - (exitText.width / 2);
        exitText.y = exit.y + (exit.height / 2) - (exitText.height / 2);
		exitText.cameras = [thatOneCameraThatWasSolelyMadeForTheExitButtonForSomeReason];
        add(exitText);
		for (e in [
			credIcon,
			credIcon2,
			credTextDev,
			credTextCon,
			credTextThanks,
			credTextDesc1,
			credTextDesc2,
			credText,
			credText2,
			specialText
		])
		{
			e.cameras = [camMain];
		}
		// FlxG.watch.add(camMain, "y");
		FlxG.worldBounds.set(0, 0, FlxG.width, FlxG.height * 3);
    }

    override public function update(elapsed:Float):Void
    {
		if (camMain.y > 0)
			camMain.y = 0;
		if (FlxG.keys.anyPressed([W, UP]))
		{
			camMain.y += 360 * FlxG.elapsed;
		}

		if (FlxG.keys.anyPressed([S, DOWN]))
		{
			camMain.y -= 360 * FlxG.elapsed;
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

		if (FlxG.mouse.overlaps(credIcon))
		{
			if (FlxG.mouse.justPressed)
			{
				FlxG.openURL("https://www.youtube.com/@SuperNovaExplosion64");
			}
		}

		if (FlxG.mouse.overlaps(credIcon2))
		{
			if (FlxG.mouse.justPressed)
			{
				FlxG.openURL("https://x.com/defokobreasts");
			}
		}
    	super.update(elapsed);
    }
}