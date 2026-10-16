package;

import PlayState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.sound.FlxSound;
import flixel.text.FlxText;

class GameOverState extends FlxState
{
    var deathSound:FlxSound;
	public var finalScore:Int;
	public var gameOverSprite:FlxSprite;

	var scoreText:FlxText;

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
		gameOverSprite = new FlxSprite();
		gameOverSprite.loadGraphic(Paths.image('menu/game-over'), true, 256, 258);
		gameOverSprite.animation.add("idle", [
			0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23
		], 24, true);
		gameOverSprite.animation.play("idle");
		gameOverSprite.screenCenter();
		gameOverSprite.y += 100;
		add(gameOverSprite);
    }

    override public function update(elapsed:Float)
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