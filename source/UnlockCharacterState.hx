package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class UnlockCharacterState extends FlxState
{
    public var sprite:FlxSprite;
    public var text:FlxText;
    public var characterImage:FlxSprite;
    public var daString:String;
    public var imageString:String;

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
	    sprite.makeGraphic(Std.int(FlxG.width * 0.7), Std.int(FlxG.height * 0.12), FlxColor.BLUE);
		sprite.screenCenter();
		add(sprite);

        text = new FlxText(0, 0, sprite.width, 16);
        text.text = "You can now play as: " + daString;
        text.screenCenter();
        add(text);

        characterImage = new FlxSprite();
        characterImage.loadGraphic(Paths.image(imageString));
        characterImage.setGraphicSize(64, 64);
        characterImage.x = text.x + text.width;
        characterImage.y = text.y;
        add(characterImage);
    }

    override public function update(elapsed:Float):Void
    {
    	super.update(elapsed);
    }
}

enum UnlockType
{
    IShowerSpeed;
}