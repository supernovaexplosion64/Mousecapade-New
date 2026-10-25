package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class UnlockCharacterState extends FlxState
{
    public var sprite:FlxSprite;
    public var text:FlxText;
    public var characterImage:FlxSprite;
    public var daString:String;
    public var imageString:String;
	public var noteText:FlxText;
	public var noteText2:FlxText;

	override public function create()
    {
    	super.create();

        /*switch character()
        {
            case IShowerSpeed:
                daString = 'IShowerSpeed';
                imageString = 'speed';
        }*/

		FlxG.save.data.speedUnlocked = true;

        daString = 'IShowerSpeed';
        imageString = 'speed';

        sprite = new FlxSprite();
		sprite.makeGraphic(Std.int(FlxG.width * 0.7), Std.int(FlxG.height * 0.12), 0xFF4342F4);
		sprite.screenCenter();
		sprite.alpha = 0;
		add(sprite);

		text = new FlxText();
        text.text = "You can now play as: " + daString;
		text.setFormat("Times New Roman", 30, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		text.antialiasing = true;
        text.screenCenter();
		text.x += 12;
		text.alpha = 0;
        add(text);

        characterImage = new FlxSprite();
        characterImage.loadGraphic(Paths.image(imageString));
        characterImage.setGraphicSize(64, 64);
		characterImage.updateHitbox();
		characterImage.x = text.x + text.width + 12;
		characterImage.y = text.y + ((text.height / 2) - (characterImage.height / 2));
		characterImage.alpha = 0;
        add(characterImage);
		noteText = new FlxText(0, 0, FlxG.width);
		noteText.text = "Press enter or space to restart game\nPress escape or backspace to exit to main menu";
		noteText.setFormat("Times New Roman", 36, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.GRAY);
		noteText.antialiasing = true;
		noteText.screenCenter(X);
		noteText.y = FlxG.height - noteText.height - 12;
		noteText.alpha = 0;
		add(noteText);

		noteText2 = new FlxText(0, 0, FlxG.width);
		noteText2.text = "Press the number 7 on the main menu to enable/disable speed mode!";
		noteText2.setFormat("Times New Roman", 36, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.GRAY);
		noteText2.antialiasing = true;
		noteText2.screenCenter(X);
		noteText2.y = 12;
		noteText2.alpha = 0;
		add(noteText2);

		new FlxTimer().start(3, function(tmr:FlxTimer)
		{
			var weirdSoundJingle:FlxSound = new FlxSound();
			weirdSoundJingle = FlxG.sound.load(Paths.sound('weird-route-jingle'));
			weirdSoundJingle.play();

			var characterSound:FlxSound = new FlxSound();
			characterSound = FlxG.sound.load(Paths.sound('bark'));
			for (i in 0...3)
			{
				new FlxTimer().start(i * 0.5, function(tmr:FlxTimer)
				{
					characterSound.play();
				});
			}
			for (e in [sprite, text, characterImage])
			{
				FlxTween.tween(e, {alpha: 1}, 0.6);
			}
			FlxTween.tween(noteText, {alpha: 1}, 1.6, {startDelay: 1.6});
			FlxTween.tween(noteText, {alpha: 1}, 1.6, {startDelay: 2.4});
		});
    }

    override public function update(elapsed:Float):Void
    {
		if (FlxG.keys.anyJustPressed([ENTER, SPACE]))
		{
			FlxG.switchState(new PlayState());
		}

		if (FlxG.keys.anyJustPressed([ESCAPE, BACKSPACE]))
		{
			FlxG.switchState(new MainMenuState());
		}

    	super.update(elapsed);
    }
}

enum UnlockType
{
    IShowerSpeed;
}