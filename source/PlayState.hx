package;

#if desktop
import Sys;
#end
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
#if (desktop || android)
import hxcodec.flixel.FlxVideo;
#end

class PlayState extends FlxState
{
	public var player:Player;
	public var cheeses:FlxTypedGroup<Item>;
	public var wegas:FlxTypedGroup<Wega>;
	public var phones:FlxTypedGroup<PickUpThePhone>;
	public var popUp:PopUp;

	var randomX = FlxG.random.int(0, 600);
	var randomY = FlxG.random.int(0, 600);

	public var score:Int = 0;
	public var wegaTimes:Int = 0;
	public var scoreText:FlxText;
	public var decreasingMultiplier:Float = 100;
	public var bonusStreak:Int = 0;

	public var itemScore:Int;

	public var time:Float = 120;
	public var timeText:FlxText;

	var popUpEnabled:Bool = true;

	// public var camGame:FlxCamera;
	public var camHUD:FlxCamera;

	var bg:FlxSprite;

	override public function create()
	{
		score = 0;
		FlxG.worldBounds.set(0, 0, 1280, 1280);
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

		phones = new FlxTypedGroup<PickUpThePhone>();
		add(phones);

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
		FlxG.worldBounds.set(player.x - 100, player.y - 100, 1280, 720);
		spawnCheese();
		spawnWega();
		spawnPhone();
		updateTime();
		decreasingMultiplier -= 8 * FlxG.elapsed;
		if (decreasingMultiplier < 2)
			decreasingMultiplier = 2;
		player.updateHitbox();
		FlxG.overlap(player, cheeses, playerTouchItem);
		FlxG.overlap(player, wegas, playerTouchWega);
		FlxG.overlap(player, phones, playerTouchPhone);
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
			itemScore = Item.value;
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
			itemTimer(wega);
		}
	}

	public function spawnPhone()
	{
		var randomChanceToAppear:Float = FlxG.random.float(0.3, 0.75);
		var phoneAppear:Bool = FlxG.random.bool(randomChanceToAppear);
		if (phoneAppear)
		{
			var positionX = player.x + FlxG.random.int(-1280, 1280);
			var positionY = player.y + FlxG.random.int(-720, 720);
			var phone = new PickUpThePhone(positionX, positionY);
			// cheese.cameras = [camGame];
			phones.add(phone);
			phone.updateHitbox();
			itemTimer(phone);
		}
	}
	public function updateTime()
	{
		time -= 1 * FlxG.elapsed;
		timeText.text = "Time: " + Std.string(Std.int(time));
		timeText.updateHitbox();
	}
	public function addScore():Int
	{
		var addYourScore:Int = Std.int((100 * itemScore) + decreasingMultiplier + (bonusStreak * 75));
		return addYourScore;
	}

	public function takeAwayScore():Int
	{
		wegaTimes += 1;
		if (wegaTimes > 50)
			wegaTimes = 50;
		var takeAwayYourScore:Int = 50 * wegaTimes;
		return takeAwayYourScore;
	}

	public function updateScore(type:String)
	{
		if (type == 'add')
		{
			score += addScore();
			#if debug trace("Score addition: " + Std.string(addScore()) + ", Decreasing Multiplier: " + Std.string(decreasingMultiplier)); #end
		}
		if (type == 'take')
		{
			score -= takeAwayScore();
		}
		scoreText.text = "Score: " + Std.string(score);
		decreasingMultiplier = 100 - (2 * wegaTimes);
	}

	function playerTouchItem(player:Player, item:Item)
	{
		if (player.alive && player.exists && item.alive && item.exists)
		{
			item.kill();
			updateScore('add');
			if (popUpEnabled)
				showPopUp('normal');
		}
	}

	function playerTouchWega(player:Player, item:Wega)
	{
		if (player.alive && player.exists && item.alive && item.exists)
		{
			item.kill();
			updateScore('take');
			if (popUpEnabled)
				showPopUp('wega');
		}
	}

	function playerTouchPhone(player:Player, item:PickUpThePhone)
	{
		if (player.alive && player.exists && item.alive && item.exists)
		{
			item.kill();
		}
		#if (desktop || android)
		var video:FlxVideo = new FlxVideo();
		video.play("assets/videos/pick-up-the-phone-new.mp4");
		/*if (!videoPlaying)
			{
				FlxG.sound.music.pause();
				videoPlaying = true;
				video.play("assets/videos/pick-up-the-phone.mp4");
		}*/
		new FlxTimer().start(9.5, function(tmr:FlxTimer)
		{
			#if desktop
			if (FlxG.random.bool(10))
			{
				Sys.exit(0);
			}
			else
			{
				// FlxG.switchState(new MainMenuState());
				// FlxG.sound.music.resume();
				video.dispose();
			}
			#else
			// FlxG.switchState(new MainMenuState());
			// FlxG.sound.music.resume();
			video.dispose();
			#end
		});
		#else
		if (FlxG.random.bool(20))
		{
			FlxG.openURL("https://youtu.be/ChnqPMwQIKc");
			// FlxG.switchState(new MainMenuState());
		}
		else
		{
			FlxG.openURL("https://youtu.be/UwGiXZOC-SQ");
			// FlxG.switchState(new MainMenuState());
		}
		#end
	}
	function itemTimer(item:FlxBasic)
	{
		var timerTime:Float = 6;
		new FlxTimer().start(timerTime, function(tmr:FlxTimer)
		{
			item.kill();
		});
	}

	function showPopUp(type:String)
	{
		popUp = new PopUp();
		if (type == 'normal')
			popUp.getPopUp(Normal);
		if (type == 'wega')
			popUp.getPopUp(Wega);
		popUp.cameras = [camHUD];
		add(popUp);
		FlxTween.tween(popUp, {alpha: 0}, 0.3);
		new FlxTimer().start(time, function(tmr:FlxTimer)
		{
			remove(popUp);
		});
	}
}
