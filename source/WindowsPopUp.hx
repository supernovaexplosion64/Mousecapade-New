package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.group.FlxSpriteGroup;

class WindowsPopUp extends FlxSpriteGroup
{
    public var window:FlxSprite;
    public var popUpAdd:FlxSprite;

    public var popUps:Array<String> = [
        'feedme',
        'quiddy'
    ];

	public function new(x:Float, y:Float)
	{
        super(x, y);

        window = new FlxSprite();
        window.loadGraphic(Paths.image('window'));
        add(window);

        popUpAdd = new FlxSprite();
        popUpAdd.loadGraphic(Paths.image('popups/placeholder'));
		popUpAdd.scale.set(1014 / popUpAdd.width, 570 / popUpAdd.height);
        getPopUp();
		// popUpAdd.updateHitbox();
        popUpAdd.x = 5;
        popUpAdd.y = 35;
        add(popUpAdd);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

    public function getPopUp()
	{
		var popUpNums:Int = popUps.length;
		popUpAdd.loadGraphic(Paths.image('popups/window/${popUps[FlxG.random.int(0, popUpNums - 1)]}'));
    }
}