package;

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
    public var credText:FlxText;
	public var credText2:FlxText;
    public var specialText:FlxText;
	public var bg:FlxBackdrop;
	public var credIcon:FlxSprite;
	public var credIcon2:FlxSprite;

    public var exit:FlxSprite;
    public var exitText:FlxText;

	override public function create()
    {
    	super.create();

		bg = new FlxBackdrop(Paths.image("bg-misery"));
		bg.alpha = 0;
		bg.screenCenter();
		add(bg);

		credIcon = new FlxSprite();
		credIcon.loadGraphic(Paths.image("credits/rico"));
		credIcon.setGraphicSize(256, 256);
		credIcon.updateHitbox();
		credIcon.x = 12;
		credIcon.y = 12;
		add(credIcon);

		credIcon2 = new FlxSprite();
		credIcon2.loadGraphic(Paths.image("credits/sammie"));
		credIcon2.setGraphicSize(256, 256);
		credIcon2.updateHitbox();
		credIcon2.x = 12;
		credIcon2.y = (FlxG.height / 2) + 12;
		add(credIcon2);

		var credTextDev:FlxText = new FlxText(0, 0, 0, "Developers", 32);
		credTextDev.setFormat("Times New Roman", 32, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		credTextDev.antialiasing = true;
		credTextDev.screenCenter(X);
		add(credTextDev);

		var credTextCon:FlxText = new FlxText(0, 0, 0, "Contributors", 32);
		credTextCon.setFormat("Times New Roman", 32, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		credTextCon.antialiasing = true;
		credTextCon.screenCenter(X);
		credTextCon.y = credIcon.y + credIcon.height + 12;
		add(credTextCon);

		var credTextDesc1:FlxText = new FlxText(credIcon.x + credIcon.width + 12, credIcon.y, 0, "supernovaexplosion64", 28);
		credTextDesc1.setFormat("Times New Roman", 36, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		credTextDesc1.antialiasing = true;
		add(credTextDesc1);

		var credTextDesc2:FlxText = new FlxText(credIcon2.x + credIcon2.width + 12, credIcon2.y, 0, "sammieGHA", 28);
		credTextDesc2.setFormat("Times New Roman", 36, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
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
		specialText.text = "Special Thanks:\nDevelopers of Vs. Mouse\nThe Ancient Mice Dev Team\nVs. Mouse: Cheesed Up!";
		specialText.setFormat("Times New Roman", 36, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		specialText.x = FlxG.width - specialText.width - 12;
		specialText.y = FlxG.height - specialText.height - 12;
		add(specialText);

        exit = new FlxSprite();
        exit.makeGraphic(72, 72, FlxColor.RED);
        exit.x = FlxG.width - exit.width - 12;
        exit.y = 12;
        add(exit);

        exitText = new FlxText();
        exitText.text = 'EXIT';
        exitText.size = 18;
        exitText.x = exit.x + (exit.width / 2) - (exitText.width / 2);
        exitText.y = exit.y + (exit.height / 2) - (exitText.height / 2);
        add(exitText);
		// FlxG.watch.add(FlxG.camera, "y");
    }

    override public function update(elapsed:Float):Void
    {
		if (FlxG.camera.y < 0)
			FlxG.camera.y = 0;
		if (FlxG.keys.anyPressed([W, UP]))
		{
			FlxG.camera.y -= 360 * FlxG.elapsed;
		}

		if (FlxG.keys.anyPressed([S, DOWN]))
		{
			FlxG.camera.y += 360 * FlxG.elapsed;
		}

        if (FlxG.mouse.overlaps(exit))
        {
            for (e in [exit, exitText])
            {
                FlxTween.tween(e, {alpha: 0.6}, 0.6);
            }

            if (FlxG.mouse.justPressed)
            {
                FlxG.switchState(new MainMenuState());
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