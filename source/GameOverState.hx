package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.sound.FlxSound;
import flixel.text.FlxText;

class GameOverState extends FlxState
{
    var deathSound:FlxSound;

    override public function create()
    {
    	super.create();
        deathSound = new FlxSound();
        deathSound = FlxG.sound.load(Paths.sound("death"));
        deathSound.play();
    }

    override public function update(elapsed:Float)
    {
    	super.update(elapsed);
    }
}