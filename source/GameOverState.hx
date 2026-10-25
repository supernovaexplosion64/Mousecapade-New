package;

import PlayState;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;

class GameOverState extends FlxState
{
	public var camMain:FlxCamera;
    var deathSound:FlxSound;
	public var finalScore:Int;
	public var finalTime:Float;
	public var gameOverSprite:FlxSprite;
	public var noteText:FlxText;
	public var quoteText:FlxText;
	public var deathConfirmed:Bool = false;

	public var shadowSprite:FlxSprite;

	var scoreText:FlxText;
	var timeText:FlxText;
	var retryText:FlxText;
	public var songBPM:Float = 140;

	public var messages:Array<String> = [
		'Never come back again.',
		"You mickey'd your last mousecapade",
		"Blud said Thick of It was a good song",
		"Better luck next time!",
		"Markus, you are now ELIMINATED!",
		"He didn't get fed",
		"You died. Now go play an actual good video game",
		"This piece of music was composed by Layer09!",
		"Good bye everyone I'm taking a shower",
		"One, two, three, four, who do we, not adore? Markus!",
		"You didn't pick up the phone"
	];

    override public function create()
    {
    	super.create();
		camMain = new FlxCamera();
		camMain.bgColor.alpha = 0;
		FlxG.cameras.add(camMain, false);
		
		finalScore = PlayState.score;
		finalTime = PlayState.time;
		shadowSprite = new FlxSprite();
		shadowSprite.loadGraphic(Paths.image('menu/shadow'));
		shadowSprite.screenCenter(X);
		shadowSprite.y = (FlxG.height - shadowSprite.height) - 35;
		shadowSprite.cameras = [camMain];
		add(shadowSprite);

        deathSound = new FlxSound();
        deathSound = FlxG.sound.load(Paths.sound("death"));
        deathSound.play();
		new FlxTimer().start(1.5, function(tmr:FlxTimer)
		{
			deathSound.fadeOut(0.5, 0);
		});

		scoreText = new FlxText();
		scoreText.text = 'Score: ' + finalScore;
		scoreText.setFormat("Times New Roman", 64, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.GRAY);
		scoreText.antialiasing = true;
		scoreText.cameras = [camMain];
		scoreText.x = 72;
		scoreText.y = 12;
		add(scoreText);
		timeText = new FlxText();
		timeText.text = 'Time: ' + Std.string(FlxStringUtil.formatTime(finalTime, true));
		timeText.setFormat("Times New Roman", 64, FlxColor.WHITE, FlxTextAlign.RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.GRAY);
		timeText.antialiasing = true;
		timeText.cameras = [camMain];
		timeText.x = FlxG.width - timeText.width - 72;
		timeText.y = 12;
		add(timeText);

		var quoteLength:Int = messages.length;

		quoteText = new FlxText(0, 0, FlxG.width);
		quoteText.text = '"' + messages[FlxG.random.int(0, quoteLength - 1)] + '"';
		quoteText.setFormat("Times New Roman", 40, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.GRAY);
		quoteText.antialiasing = true;
		quoteText.cameras = [camMain];
		quoteText.screenCenter(X);
		quoteText.y = timeText.y + timeText.height + 24;
		add(quoteText);

		retryText = new FlxText();
		retryText.text = "Retry?";
		retryText.setFormat("Times New Roman", 64, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.GRAY);
		retryText.antialiasing = true;
		retryText.cameras = [camMain];
		retryText.screenCenter(X);
		retryText.y = 175;
		add(retryText);
		gameOverSprite = new FlxSprite();
		gameOverSprite.loadGraphic(Paths.image('menu/game-over'), true, 382, 274);
		gameOverSprite.animation.add("idle", [
			0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 25, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 23, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 25,
			11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1
		], 24, true);
		gameOverSprite.animation.play("idle");
		gameOverSprite.screenCenter();
		gameOverSprite.y += 100;
		gameOverSprite.cameras = [camMain];
		add(gameOverSprite);
		noteText = new FlxText(0, 0, FlxG.width);
		noteText.text = "Press enter or space to restart game\nPress escape or backspace to exit to main menu";
		noteText.setFormat("Times New Roman", 36, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.GRAY);
		noteText.antialiasing = true;
		noteText.cameras = [camMain];
		noteText.screenCenter(X);
		noteText.y = FlxG.height - noteText.height - 12;
		noteText.alpha = 0;
		add(noteText);
		camMain.alpha = 0;
		new FlxTimer().start(3, function(tmr:FlxTimer)
		{
			if (finalScore >= 250000 && !FlxG.save.data.speedUnlocked)
			{
				FlxG.switchState(new UnlockCharacterState());
			}
			else
			{
				FlxG.sound.playMusic(Paths.music('death-theme'), 1);
				FlxTween.tween(camMain, {alpha: 1}, (60 / songBPM));
				FlxTween.tween(retryText, {y: retryText.y + 36}, (60 / songBPM) * 2, {ease: FlxEase.quadInOut, type: PINGPONG});
				FlxTween.tween(noteText, {alpha: 1}, (60 / songBPM) * 4, {startDelay: (60 / songBPM) * 4});
			}
		});
    }

    override public function update(elapsed:Float)
    {
		if (FlxG.keys.anyJustPressed([ENTER, SPACE]) && !deathConfirmed)
		{
			deathConfirmed = true;
			if (FlxG.sound.music.playing)
				FlxG.sound.music.stop();
			deathConfirm();
		}

		if (FlxG.keys.anyJustPressed([ESCAPE, BACKSPACE]) && !deathConfirmed)
		{
			FlxG.switchState(new MainMenuState());
		}

    	super.update(elapsed);
    }
	public function deathConfirm()
	{
		var confirmSound:FlxSound = new FlxSound();
		confirmSound = FlxG.sound.load(Paths.sound('death-confirm'));
		confirmSound.play();
		retryText.color = FlxColor.YELLOW;
		retryText.borderColor = 0xFF808000;
		retryText.scale.set(1.3, 1.3);
		FlxTween.tween(retryText, {"scale.x": 1, "scale.y": 1}, 0.6, {ease: FlxEase.backOut});
		retryText.updateHitbox();
		retryText.screenCenter(X);
		FlxTween.tween(camMain, {alpha: 0}, 3, {startDelay: 0.6});
		new FlxTimer().start(6, function(tmr:FlxTimer)
		{
			FlxG.switchState(new PlayState());
		});
		if (FlxG.random.bool(15))
		{
			FlxTween.tween(camMain, {angle: 360 * 8}, 2.4, {ease: FlxEase.cubeIn, startDelay: 1.2});
		}
	}
}