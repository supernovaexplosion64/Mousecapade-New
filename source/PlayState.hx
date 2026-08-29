package;

import Item;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class PlayState extends FlxState
{
	public var player:Player;
	public var cheeses:FlxTypedGroup<Item>;
	public var wegas:FlxTypedGroup<Wega>;
	public var popUp:PopUp;

	var randomX = FlxG.random.int(0, 600);
	var randomY = FlxG.random.int(0, 600);

	public var score:Int = 0;
	public var scoreText:FlxText;
	public var decreasingMultiplier:Float = 100;
	public var bonusStreak:Int = 0;

	public var itemScore:Int = Item.value;

	public var time:Float = 120;
	public var timeText:FlxText;

	var popUpEnabled:Bool = true;

	// public var camGame:FlxCamera;
	public var camHUD:FlxCamera;

	var bg:FlxSprite;

	override public function create()
	{
		score = 0;
		super.create();
		bg = new FlxSprite();
		bg.makeGraphic(1280, 720, FlxColor.GRAY);
		add(bg);
		// camGame = new FlxCamera();
		camHUD = new FlxCamera();
		// camGame.bgColor.alpha = 0;
		camHUD.bgColor.alpha = 0;

		FlxG.cameras.add(camHUD, false);
		
		player = new Player();
		// player.cameras = [camGame];
		add(player);

		FlxG.camera.follow(player, LOCKON, 1);
		FlxG.camera.zoom = 0.8;

		cheeses = new FlxTypedGroup<Item>();
		// cheeses.cameras = [camGame];
		add(cheeses);

		wegas = new FlxTypedGroup<Wega>();
		add(wegas);

		scoreText = new FlxText();
		scoreText.size = 48;
		scoreText.font = "Times New Roman";
		scoreText.text = "Score: " + Std.string(score);
		scoreText.cameras = [camHUD];
		add(scoreText);

		timeText = new FlxText();
		timeText.size = 48;
		timeText.font = "Times New Roman";
		timeText.text = "Time: " + Std.string(time);
		timeText.y = scoreText.y + timeText.height + 12;
		timeText.cameras = [camHUD];
		add(timeText);
	}

	override public function update(elapsed:Float)
	{
		spawnCheese();
		spawnWega();
		updateTime();
		decreasingMultiplier -= 8 * FlxG.elapsed;
		if (decreasingMultiplier < 2)
			decreasingMultiplier = 2;
		player.updateHitbox();
		FlxG.overlap(player, cheeses, playerTouchCoin);
		super.update(elapsed);
	}

	public function spawnCheese()
	{
		var randomChanceToAppear:Float = FlxG.random.float(4, 12);
		var cheeseAppear:Bool = FlxG.random.bool(randomChanceToAppear);
		if (cheeseAppear)
		{
			var randomXA = FlxG.random.int(0, 1280 - 128);
			var randomYA = FlxG.random.int(0, 720 - 128);

			var positionX = player.x + FlxG.random.int(-1280, 1280);
			var positionY = player.y + FlxG.random.int(-720, 720);
			var cheese = new Item(positionX, positionY);
			// cheese.cameras = [camGame];
			cheeses.add(cheese);
			cheese.updateHitbox();
			itemTimer(cheese);
		}
	}

	public function spawnWega()
	{
		var randomChanceToAppear:Float = FlxG.random.float(1.5, 4.5);
		var wegaAppear:Bool = FlxG.random.bool(randomChanceToAppear);
		if (wegaAppear)
		{
			var positionX = player.x + FlxG.random.int(-1280, 1280);
			var positionY = player.y + FlxG.random.int(-720, 720);
			var wega = new Wega(positionX, positionY);
			// cheese.cameras = [camGame];
			wegas.add(wega);
			wega.updateHitbox();
			// itemTimer(cheese);
		}
	}
	public function updateTime()
	{
		time -= 1 * FlxG.elapsed;
		timeText.text = "Time: " + Std.string(Std.int(time));
		timeText.updateHitbox();
	}

	public function updateScore()
	{
		score += Std.int((100 * itemScore) + decreasingMultiplier + (bonusStreak * 75));
		#if debug trace("Score addition: " + Std.string(score) + ", Decreasing Multiplier: " + Std.string(decreasingMultiplier)); #end
		scoreText.text = "Score: " + Std.string(score);
		decreasingMultiplier = 100;
	}

	function playerTouchCoin(player:Player, item:Item)
	{
		if (player.alive && player.exists && item.alive && item.exists)
		{
			item.kill();
			updateScore();
			if (popUpEnabled)
				showPopUp();
		}
	}
	function itemTimer(item:Item)
	{
		var timerTime:Float = 6;
		new FlxTimer().start(timerTime, function(tmr:FlxTimer)
		{
			item.kill();
		});
	}

	function showPopUp()
	{
		popUp = new PopUp();
		popUp.cameras = [camHUD];
		add(popUp);
		FlxTween.tween(popUp, {alpha: 0}, 0.6);
		new FlxTimer().start(time, function(tmr:FlxTimer)
		{
			remove(popUp);
		});
	}
}
