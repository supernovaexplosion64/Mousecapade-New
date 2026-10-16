package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class InstructionGuideState extends FlxState
{
    public var text:FlxText;

	public var moreText:FlxText;

    public var exit:FlxSprite;
    public var exitText:FlxText;

    public var enemyExample:FlxSprite;
    public var enemyExample2:FlxSprite;

    public var bg:FlxSprite;

	public var types:Array<String> = ['cheeses', 'pizza'];

	public var typesAlt:Array<String> = ['Lunchlies', 'KSI', 'DanTDM'];

    override public function create()
    {
    	super.create();

        bg = new FlxSprite();
		bg.loadGraphic(Paths.image("bg"));
		bg.screenCenter();
		add(bg);

        text = new FlxText();
		text.text = 'How to play:';
		text.setFormat("Times New Roman", 48, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        text.x = 12;
        text.y = 12;
        add(text);

		moreText = new FlxText(0, 0, FlxG.width - 12);
		moreText.text = "Grab the cheeses to earn points, grab the pizza to gain health, dodge everything else";
		moreText.setFormat("Times New Roman", 36, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		moreText.screenCenter(X);
		moreText.y = text.y + text.height + 12;
		add(moreText);

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

        enemyExample = new FlxSprite();
        enemyExample.loadGraphic(Paths.enemy("wega"));
        enemyExample.x = text.x + 480;
        enemyExample.y = text.y + 72 + 12;
		// add(enemyExample);

        enemyExample2 = new FlxSprite();
        enemyExample2.loadGraphic(Paths.enemy("fnati"));
        enemyExample2.x = enemyExample.x + enemyExample.width + 12;
        enemyExample2.y = enemyExample.y;
		// add(enemyExample2);

		FlxG.sound.playMusic(Paths.music("instruction"), 1, true);
    }

    override public function update(elapsed:Float)
    {
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

		if (FlxG.keys.anyJustPressed([ESCAPE, BACKSPACE]))
		{
			FlxG.switchState(new MainMenuState());
		}

    	super.update(elapsed);
    }
}