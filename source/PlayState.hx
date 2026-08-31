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
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
#if ((desktop || android) && !hl)
import hxcodec.flixel.FlxVideo;
#end

class PlayState extends FlxState
{
	public var player:Player;
	public var cheeses:FlxTypedGroup<Item>;
	public var wegas:FlxTypedGroup<Wega>;
	public var phones:FlxTypedGroup<PickUpThePhone>;
	public var screweds:FlxTypedGroup<Screwed>;
	public var popUp:PopUp;

	var randomX = FlxG.random.int(0, 600);
	var randomY = FlxG.random.int(0, 600);

	public var score:Int = 0;
	public var wegaTimes:Int = 0;
	public var scoreText:FlxText;
	public var decreasingMultiplier:Float = 100;
	public var bonusStreak:Int = 0;

	public var itemScore:Int;
	public var itemHealthIncrease:Int;

	public var time:Float = 120;
	public var timeText:FlxText;

	var popUpEnabled:Bool = true;

	// public var camGame:FlxCamera;
	public var camHUD:FlxCamera;

	var bg:FlxSprite;
	public var health:Float = 100;
	public var healthBar:FlxBar;
	public var healthText:FlxText;

	var timerThing:Float = 3;
	var tweeningTime:Float = 0.8;

	var healthTweening:Bool = false;

	public var LEVEL:Int = 1;
	public var levelText:FlxText;

	public static var gameJustStarted:Bool = true;

	override public function create()
	{
		if (gameJustStarted)
		{
			LEVEL = 1;
		}
		gameJustStarted = false;
		super.create();

		bg = new FlxSprite();
		bg.makeGraphic(FlxG.width, FlxG.height, FlxColor.GRAY);
		bg.scrollFactor.set(0, 0);
		add(bg);

		camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;
		FlxG.cameras.add(camHUD, false);

		FlxG.sound.playMusic(Paths.music('welcome-old'), 1, true);
		
		player = new Player();
		add(player);

		FlxG.camera.follow(player, LOCKON, 1);
		FlxG.camera.zoom = 0.8;

		cheeses = new FlxTypedGroup<Item>();
		add(cheeses);

		wegas = new FlxTypedGroup<Wega>();
		add(wegas);

		phones = new FlxTypedGroup<PickUpThePhone>();
		add(phones);

		screweds = new FlxTypedGroup<Screwed>();
		add(screweds);

		scoreText = new FlxText();
		scoreText.size = 48;
		scoreText.font = "Times New Roman";
		scoreText.text = Std.string(score);
		scoreText.screenCenter(X);
		scoreText.cameras = [camHUD];
		add(scoreText);

		timeText = new FlxText();
		timeText.size = 48;
		timeText.font = "Times New Roman";
		timeText.text = Std.string(FlxStringUtil.formatTime(time));
		timeText.screenCenter(X);
		timeText.y = scoreText.y + scoreText.height + 12;
		timeText.cameras = [camHUD];
		add(timeText);
		healthBar = new FlxBar(0, 0, FlxBarFillDirection.LEFT_TO_RIGHT, 640, 20, this, "health");
		healthBar.y = FlxG.height;
		healthBar.cameras = [camHUD];
		add(healthBar);

		healthText = new FlxText();
		healthText.size = 24;
		healthText.font = "Times New Roman";
		healthText.text = "Health: " + Std.string(health);
		healthText.y = FlxG.height + healthBar.height + 24;
		healthText.cameras = [camHUD];
		add(healthText);
		levelText = new FlxText();
		levelText.size = 48;
		levelText.font = "Times New Roman";
		levelText.text = 'LEVEL ' + Std.string(LEVEL);
		// levelText.x = 12;
		// levelText.y = 12;
		levelText.cameras = [camHUD];
		add(levelText);

		new FlxTimer().start(2, function(tmr:FlxTimer)
		{
			FlxTween.tween(levelText, {y: levelText.y * -1}, 1, {ease: FlxEase.backIn});
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				remove(levelText);
			});
		});
	}

	override public function update(elapsed:Float)
	{
		FlxG.worldBounds.set(player.x - 100, player.y - 100, 1280, 720);
		if (time < 0 && health > 0)
		{
			// LEVEL += 1;
			FlxG.resetState();
		}
		if (health > 100)
			health = 100;
		/*if (health <= 0)
			{
				FlxG.resetGame();
				LEVEL = 1;
		}*/
		healthText.text = "Health: " + Std.string(health);
		spawnCheese();
		spawnWega();
		// spawnPhone();
		spawnScrewed();
		updateTime();
		decreasingMultiplier -= 8 * FlxG.elapsed;
		if (decreasingMultiplier < 2)
			decreasingMultiplier = 2;
		if (healthTweening)
			healthEasing();
		player.updateHitbox();
		FlxG.overlap(player, cheeses, playerTouchItem);
		FlxG.overlap(player, wegas, playerTouchWega);
		FlxG.overlap(player, phones, playerTouchPhone);
		FlxG.overlap(player, screweds, playerTouchScrewed);
		super.update(elapsed);
	}

	public function spawnCheese()
	{
		var randomChanceToAppear:Float = FlxG.random.float(4, 12);
		var cheeseAppear:Bool = FlxG.random.bool(randomChanceToAppear);
		if (cheeseAppear)
		{
			var positionX = player.x + FlxG.random.int(-1280, 1280);
			var positionY = player.y + FlxG.random.int(-720, 720);
			var cheese = new Item(positionX, positionY);
			// itemScore = cheese.value;
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
	public function spawnScrewed()
	{
		var randomChanceToAppear:Float = FlxG.random.float(2, 7);
		var screwedAppear:Bool = FlxG.random.bool(randomChanceToAppear);
		if (screwedAppear)
		{
			var positionX = player.x + FlxG.random.int(-1280, 1280);
			var positionY = player.y + FlxG.random.int(-720, 720);
			var screwed = new Screwed(positionX, positionY);
			// cheese.cameras = [camGame];
			screweds.add(screwed);
			screwed.updateHitbox();
			itemTimer(screwed);
		}
	}

	public function updateTime()
	{
		time -= 1 * FlxG.elapsed;
		timeText.text = Std.string(FlxStringUtil.formatTime(time));
		timeText.screenCenter(X);
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
			decreasingMultiplier = 100 - (2 * wegaTimes);
			#if debug trace("Score addition: " + Std.string(addScore()) + ", Decreasing Multiplier: " + Std.string(decreasingMultiplier)); #end
		}
		if (type == 'take')
		{
			score -= takeAwayScore();
		}
		scoreText.text = Std.string(score);
		scoreText.screenCenter(X);
	}

	public function addHealth()
	{
		health += itemHealthIncrease;
		healthText.text = "Health: " + Std.string(health);
		if (!healthTweening)
			showHealth();
	}

	public function takeAwayHealth()
	{
		health -= 5;
		healthText.text = "Health: " + Std.string(health);
		if (!healthTweening)
			showHealth();
	}

	public function showHealth()
	{
		timerThing = 3;
		healthTweening = true;
		FlxTween.tween(healthBar, {y: FlxG.height - healthBar.height}, tweeningTime, {ease: FlxEase.backOut});
		FlxTween.tween(healthText, {y: FlxG.height - healthBar.height - 36}, tweeningTime, {ease: FlxEase.backOut});
	}

	public function healthEasing()
	{
		timerThing -= 1 * FlxG.elapsed;
		#if debug trace(timerThing); #end
		if (timerThing <= 0)
		{
			FlxTween.tween(healthBar, {y: FlxG.height}, tweeningTime, {ease: FlxEase.backIn});
			FlxTween.tween(healthText, {y: FlxG.height + healthBar.height + 36}, tweeningTime, {ease: FlxEase.backIn});
			new FlxTimer().start(tweeningTime, function(tmr:FlxTimer)
			{
				healthTweening = false;
			});
		};
	}

	function playerTouchItem(player:Player, item:Item)
	{
		if (player.alive && player.exists && item.alive && item.exists)
		{
			item.kill();
			itemScore = item.value;
			itemHealthIncrease = item.healthIncrease;
			addHealth();
			updateScore('add');
			if (popUpEnabled)
				showPopUp(Normal);
		}
	}

	function playerTouchWega(player:Player, item:Wega)
	{
		if (player.alive && player.exists && item.alive && item.exists)
		{
			item.kill();
			updateScore('take');
			takeAwayHealth();
			if (popUpEnabled)
				showPopUp(Wega);
		}
	}

	function playerTouchPhone(player:Player, item:PickUpThePhone)
	{
		if (player.alive && player.exists && item.alive && item.exists)
		{
			item.kill();
		}
		#if ((desktop || android) && !hl)
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
	function playerTouchScrewed(player:Player, item:Screwed)
	{
		if (player.alive && player.exists && item.alive && item.exists)
		{
			item.kill();
			updateScore('take');
			takeAwayHealth();
			// if (popUpEnabled)
			shatterScreen(item.getType());
		}
	}

	function itemTimer(item:FlxBasic)
	{
		var timerTime:Float = 6;
		new FlxTimer().start(timerTime, function(tmr:FlxTimer)
		{
			item.kill();
		});
	}

	function showPopUp(type:PopUp.PopUpType)
	{
		popUp = new PopUp();
		popUp.getPopUp(type);
		popUp.cameras = [camHUD];
		add(popUp);
		FlxTween.tween(popUp, {alpha: 0}, 0.3);
		new FlxTimer().start(time, function(tmr:FlxTimer)
		{
			remove(popUp);
		});
	}
	function shatterScreen(type:Screwed.ScrewedType)
	{
		var randomX:Int = FlxG.random.int(0, FlxG.width);
		var randomY:Int = FlxG.random.int(0, FlxG.height);
		var crack:FlxSprite;
		crack = new FlxSprite();
		crack.loadGraphic(Paths.image('crack'));
		crack.cameras = [camHUD];
		crack.x = randomX;
		crack.y = randomY;
		switch (type)
		{
			case Normal:
				crack.scale.set(0.9, 0.9);
				crack.alpha = 0.3;
				FlxG.camera.shake(0.1, 0.1);
			case Red:
				crack.scale.set(1.2, 1.2);
				crack.alpha = 0.5;
				FlxG.camera.shake(0.15, 0.2);
			case New:
				crack.scale.set(1.6, 1.6);
				crack.alpha = 0.8;
				FlxG.camera.shake(0.2, 0.25);
			case Angry:
				crack.scale.set(2.2, 2.2);
				crack.alpha = 1;
				FlxG.camera.shake(0.3, 0.35);
		}
		add(crack);
	}
}
