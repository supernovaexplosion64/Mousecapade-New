package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class OptionsState extends FlxState
{
    public var bg:FlxSprite;

	override public function create()
    {
    	super.create();

        bg = new FlxSprite();
		bg.loadGraphic(Paths.image("bg-misery"));
		bg.screenCenter();
		add(bg);
    }

    override public function update(elapsed:Float):Void
    {
    	super.update(elapsed);
    }
}