package;

import PlayState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.sound.FlxSound;
import flixel.text.FlxText;

class GameOverState extends FlxSubState
{
    var deathSound:FlxSound;
	public var finalScore:Int;

	var scoreText:FlxText;

	public function new()
	{
		super();
	}

    override public function create()
    {
    	super.create();
		finalScore = PlayState.score;
        deathSound = new FlxSound();
        deathSound = FlxG.sound.load(Paths.sound("death"));
        deathSound.play();
		scoreText = new FlxText();
		scoreText.text = 'Score: ' + finalScore;
		scoreText.size = 64;
		scoreText.antialiasing = true;
		scoreText.scrollFactor.set(0, 0);
		scoreText.screenCenter(X);
		add(scoreText);
    }

    override public function update(elapsed:Float)
    {
    	super.update(elapsed);
    }
}