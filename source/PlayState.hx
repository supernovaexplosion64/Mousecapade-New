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
	public var windows:FlxTypedGroup<WindowsPopUp>;
	public var pizzas:FlxTypedGroup<Pizza>;

	var randomX = FlxG.random.int(0, 600);
	var randomY = FlxG.random.int(0, 600);

	public var score:Int = 0;
	public var wegaTimes:Int = 0;
	public var scoreText:FlxText;
	public var decreasingMultiplier:Float = 100;
	public var bonusStreak:Int = 0;

	public var itemScore:Int;
	public var itemHealthIncrease:Int;

	public var screwed_healthDecrease:Float;
	public var screwed_daGraphic:String;
	public var screwed_daScale:Float;
	public var screwed_daShake:Float;
	public var screwed_randomMulti:Float;
	public var screwed_alphaAlpha:Float;

	public var time:Float = 0;
	public var timeText:FlxText;

	var popUpEnabled:Bool = true;

	// public var camGame:FlxCamera;
	public var camHUD:FlxCamera;
	public var camMain:FlxCamera;
	public var camWindow:FlxCamera;

	var bg:FlxSprite;
	public var health:Float = 100;
	public var healthBar:FlxBar;
	public var healthText:FlxText;

	public var theOtherBar:FlxBar;
	public var secondaryHealth:Float = 50;

	var timerThing:Float = 3;
	var tweeningTime:Float = 0.8;
	var stopMyTimer:Bool = false;

	var healthTweening:Bool = false;

	public var LEVEL:Int = 1;
	public var levelText:FlxText;

	public static var gameJustStarted:Bool = true;

	public var breakSound:FlxSound;

	var newEnemyText:FlxText;

	public var theDelta:Float;

	var normal_bpm:Float = 173;
	var fast_bpm:Float = 200;
	var slow_bpm:Float = 130;

	var ateThePizza:Bool = false;

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

		camMain = new FlxCamera();
		camMain.bgColor.alpha = 0;
		FlxG.cameras.add(camMain, false);

		camWindow = new FlxCamera();
		camWindow.bgColor.alpha = 0;
		FlxG.cameras.add(camWindow, false);

		FlxG.sound.playMusic(Paths.music('maintheme/normal'), 1, true);
		
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

		windows = new FlxTypedGroup<WindowsPopUp>();
		add(windows);

		pizzas = new FlxTypedGroup<Pizza>();
		add(pizzas);

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
		timeText.text = Std.string(FlxStringUtil.formatTime(time, true));
		timeText.screenCenter(X);
		timeText.y = scoreText.y + scoreText.height + 12;
		timeText.cameras = [camHUD];
		add(timeText);
		healthBar = new FlxBar(0, 0, FlxBarFillDirection.LEFT_TO_RIGHT, 640, 20, this, "health");
		healthBar.y = FlxG.height;
		healthBar.cameras = [camMain];
		add(healthBar);

		theOtherBar = new FlxBar(0, 0, FlxBarFillDirection.LEFT_TO_RIGHT, 320, 20, this, "secondaryHealth", 0, 50);
		theOtherBar.createFilledBar(0xFF008080, 0xFF00FFFF);
		theOtherBar.x = 640;
		theOtherBar.y = FlxG.height;
		theOtherBar.alpha = 0;
		theOtherBar.cameras = [camMain];
		add(theOtherBar);

		healthText = new FlxText();
		healthText.size = 24;
		healthText.font = "Times New Roman";
		healthText.text = "Health: " + Std.string(health);
		healthText.y = FlxG.height + healthBar.height + 24;
		healthText.cameras = [camMain];
		add(healthText);
		levelText = new FlxText();
		levelText.size = 48;
		levelText.font = "Times New Roman";
		levelText.text = 'LEVEL ' + Std.string(LEVEL);
		// levelText.x = 12;
		// levelText.y = 12;
		levelText.cameras = [camHUD];
		add(levelText);

		newEnemyText = new FlxText();
		newEnemyText.size = 24;
		newEnemyText.font = "Times New Roman";
		newEnemyText.text = '';
		newEnemyText.cameras = [camHUD];
		add(newEnemyText);

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
		theDelta = FlxG.elapsed;
		FlxG.worldBounds.set(player.x - 100, player.y - 100, 1280, 720);
		/*if (time < 0 && health > 0)
		{
			// LEVEL += 1;
			FlxG.resetState();
		}*/
		if (health > 100 && !ateThePizza)
		{
			health = 100;
		}
		else if (health > 150 && ateThePizza)
		{
			health = 150;
		}

		if (health > 100 && ateThePizza)
		{
			theOtherBar.alpha = 1;
			secondaryHealth = health - 100;
			if (secondaryHealth > 50)
				secondaryHealth = 50;
		}

		changeMusic();
		/*if (health <= 0)
			{
				FlxG.resetGame();
				LEVEL = 1;
		}*/
		healthText.text = "Health: " + Std.string(health);
		showNewEnemyText(30, "Wegas have started to appear!");
		showNewEnemyText(60, "Bambis have started to appear!");
		spawnCheese();
		spawnPizza();
		// if (time >= 15)
		spawnWega();
		// if (time >= 120)
		spawnPhone();
		// if (time >= 60)
		spawnScrewed();
		spawnFunny();
		updateTime();
		decreasingMultiplier -= 8 * FlxG.elapsed;
		if (decreasingMultiplier < 2)
			decreasingMultiplier = 2;
		if (healthTweening)
			healthEasing();
		player.updateHitbox();
		FlxG.overlap(player, cheeses, playerTouchItem);
		FlxG.overlap(player, pizzas, playerTouchPizza);
		FlxG.overlap(player, wegas, playerTouchWega);
		FlxG.overlap(player, phones, playerTouchPhone);
		FlxG.overlap(player, screweds, playerTouchScrewed);
		super.update(elapsed);
		spawnWindows();
	}

	var stopMusic:Bool = true;
	var stopFastMusic:Bool = false;
	var stopSlowMusic:Bool = false;

	public function changeMusic()
	{
		if (health < 20 && !stopFastMusic)
		{
			FlxG.sound.playMusic(Paths.music('maintheme/fast'), 1, true);
			stopFastMusic = !stopFastMusic;
			if (stopMusic)
				stopMusic = !stopMusic;
			if (stopSlowMusic)
				stopSlowMusic = !stopSlowMusic;
		}
		else if (health > 100 && !stopSlowMusic)
		{
			FlxG.sound.playMusic(Paths.music('maintheme/slow'), 1, true);
			stopSlowMusic = !stopSlowMusic;
			if (stopMusic)
				stopMusic = !stopMusic;
			if (stopFastMusic)
				stopFastMusic = !stopFastMusic;
		}
		else if (health >= 20 && health <= 100 && !stopMusic)
		{
			FlxG.sound.playMusic(Paths.music('maintheme/normal'), 1, true);
			stopMusic = !stopMusic;
			if (stopSlowMusic)
				stopSlowMusic = !stopSlowMusic;
			if (stopFastMusic)
				stopFastMusic = !stopFastMusic;
		}
	}

	public function spawnCheese()
	{
		var randomChanceToAppear:Float = FlxG.random.float(4, 12);
		var cheeseAppear:Bool = FlxG.random.bool(randomChanceToAppear * theDelta * 60);
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

	public function spawnPizza()
	{
		var randomChanceToAppear:Float = FlxG.random.float(0.08, 0.24);
		var pizzaAppear:Bool = FlxG.random.bool(randomChanceToAppear * theDelta * 60);
		if (pizzaAppear)
		{
			var positionX = player.x + FlxG.random.int(-1280, 1280);
			var positionY = player.y + FlxG.random.int(-720, 720);
			var pizza = new Pizza(positionX, positionY);
			// itemScore = cheese.value;
			pizzas.add(pizza);
			pizza.updateHitbox();
			itemTimerPizza(pizza);
		}
	}

	public function spawnWega()
	{
		var randomChanceToAppear:Float = FlxG.random.float(1.5, 4.5);
		var wegaAppear:Bool = FlxG.random.bool(randomChanceToAppear * (time / 30) * theDelta * 60);
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
		var phoneAppear:Bool = FlxG.random.bool(randomChanceToAppear * (time / 75) * theDelta * 60);
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
		var screwedAppear:Bool = FlxG.random.bool(randomChanceToAppear * (time / 120) * theDelta * 60);
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

	public function spawnWindows()
	{
		var randomChanceToAppear:Float = FlxG.random.float(0.2, 0.3);
		var windowsAppear:Bool = FlxG.random.bool(randomChanceToAppear * theDelta * 60);
		if (windowsAppear)
		{
			var positionX = FlxG.random.int(0, FlxG.width - 100);
			var positionY = FlxG.random.int(0, FlxG.height - 100);
			var window = new WindowsPopUp(positionX - 500, positionY - 300);
			window.scale.set(0.3, 0.3);
			window.alpha = 0;
			window.cameras = [camWindow];
			window.updateHitbox();
			windows.add(window);
			FlxTween.tween(window, {alpha: 1}, 0.3);
			itemTimer(window);
		}
	}

	public function updateTime()
	{
		time += 1 * FlxG.elapsed;
		timeText.text = Std.string(FlxStringUtil.formatTime(time, true));
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

	public function addHealth(healthGiven:Float = 25)
	{
		health += itemHealthIncrease;
		healthText.text = "Health: " + Std.string(health);
		timerThing = 3;
		if (!healthTweening)
			showHealth();
	}

	public function takeAwayHealth(healthTaken:Float = 5)
	{
		health -= healthTaken;
		healthText.text = "Health: " + Std.string(health);
		timerThing = 3;
		if (!healthTweening)
			showHealth();
	}

	public function showHealth()
	{
		healthTweening = true;
		FlxTween.tween(healthBar, {y: FlxG.height - healthBar.height}, tweeningTime, {ease: FlxEase.backOut});
		FlxTween.tween(theOtherBar, {y: FlxG.height - theOtherBar.height}, tweeningTime, {ease: FlxEase.backOut});
		FlxTween.tween(healthText, {y: FlxG.height - healthBar.height - 36}, tweeningTime, {ease: FlxEase.backOut});
	}

	public function healthEasing()
	{
		timerThing -= 1 * FlxG.elapsed;
		// #if debug trace(timerThing); #end
		if (timerThing <= 0 && !stopMyTimer)
		{
			stopMyTimer = true;
			FlxTween.tween(healthBar, {y: FlxG.height}, tweeningTime, {ease: FlxEase.backIn});
			FlxTween.tween(theOtherBar, {y: FlxG.height}, tweeningTime, {ease: FlxEase.backIn});
			FlxTween.tween(healthText, {y: FlxG.height + healthBar.height + 36}, tweeningTime, {ease: FlxEase.backIn});
			new FlxTimer().start(tweeningTime, function(tmr:FlxTimer)
			{
				healthTweening = false;
				stopMyTimer = false;
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

	function playerTouchPizza(player:Player, item:Pizza)
	{
		if (player.alive && player.exists && item.alive && item.exists)
		{
			ateThePizza = true;
			item.kill();
			itemHealthIncrease = 25;
			addHealth();
			updateScore('add');
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
			var fnatiJumpscare:FlxSprite;
			fnatiJumpscare = new FlxSprite();
			fnatiJumpscare.loadGraphic(Paths.image('fnatijumpscare'), 800, 450);
			fnatiJumpscare.animation.add("idle", [
				0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
			], 24, true);
			fnatiJumpscare.animation.play("idle");
			fnatiJumpscare.cameras = [camHUD];
			add(fnatiJumpscare);
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				fnatiJumpscare.kill();
			});
		}
	}
	function playerTouchScrewed(player:Player, item:Screwed)
	{
		if (player.alive && player.exists && item.alive && item.exists)
		{
			item.kill();
			screwed_healthDecrease = item.healthDecrease;
			screwed_daGraphic = item.daGraphic;
			screwed_daScale = item.daScale;
			screwed_daShake = item.daShake;
			screwed_randomMulti = item.randomMulti;
			screwed_alphaAlpha = item.alphaAlpha;
			updateScore('take');
			takeAwayHealth(screwed_healthDecrease);
			// if (popUpEnabled)
			shatterScreen();
		}
	}

	function itemTimer(item:FlxBasic, timeTime:Float = 6)
	{
		var timerTime:Float = timeTime;
		new FlxTimer().start(timerTime, function(tmr:FlxTimer)
		{
			item.kill();
		});
	}

	function itemTimerPizza(item:FlxBasic, timeTime:Float = 30)
	{
		var timerTime:Float = timeTime;
		new FlxTimer().start(timerTime, function(tmr:FlxTimer)
		{
			item.kill();
			if (health <= 100)
				ateThePizza = false;
		});
	}

	function showPopUp(type:PopUp.PopUpType)
	{
		var popUp:PopUp;
		popUp = new PopUp();
		popUp.getPopUp(type);
		popUp.cameras = [camHUD];
		add(popUp);
		FlxTween.tween(popUp, {alpha: 0}, 0.3);
		new FlxTimer().start(0.3, function(tmr:FlxTimer)
		{
			popUp.kill();
		});
	}
	function shatterScreen()
	{
		var daPhone:FlxSprite;
		var randomX:Int = FlxG.random.int(0, FlxG.width);
		var randomY:Int = FlxG.random.int(0, FlxG.height);
		var randomXA:Int = FlxG.random.int(0, FlxG.width);
		var randomYA:Int = FlxG.random.int(0, FlxG.height);
		var randomSpeedMulti:Float;
		var crack:FlxSprite;
		daPhone = new FlxSprite();
		daPhone.loadGraphic(Paths.image("phone/phone"));
		daPhone.cameras = [camHUD];

		crack = new FlxSprite();
		crack.loadGraphic(Paths.image('phone/${screwed_daGraphic}'));
		crack.scale.set(screwed_daScale, screwed_daScale);
		crack.alpha = screwed_alphaAlpha;
		FlxG.camera.shake(screwed_daShake, screwed_daShake);
		randomSpeedMulti = screwed_randomMulti;
		// daPhone.angle += 360 * randomSpeedMulti * FlxG.elapsed;
		crack.cameras = [camHUD];
		crack.x = randomX;
		crack.y = randomY;
		daPhone.angle = FlxG.random.int(0, 360);
		daPhone.scale.set(randomSpeedMulti * 0.6, randomSpeedMulti * 0.6);
		daPhone.x = randomX;
		daPhone.y = randomY;
		add(daPhone);
		new FlxTimer().start(3, function(tmr:FlxTimer)
		{
			FlxTween.tween(daPhone, {alpha: 0}, 0.6);
		});
		add(crack);
		breakSound = FlxG.sound.load(Paths.sound("phone-break"));
		breakSound.play();
	}
	function showNewEnemyText(daTime:Float, daText:String)
	{
		if (time == daTime)
		{
			newEnemyText.x = 0;
			newEnemyText.y = 0;
			newEnemyText.scale.set(0.2, 0.2);
			newEnemyText.text = daText;
			FlxTween.tween(newEnemyText.scale, {x: 1, y: 1}, 0.3, {ease: FlxEase.backOut});
			new FlxTimer().start(3, function(tmr:FlxTimer)
			{
				FlxTween.tween(newEnemyText, {angle: 45}, 2, {ease: FlxEase.cubeIn});
				FlxTween.tween(newEnemyText, {y: FlxG.height * 3}, 5, {ease: FlxEase.cubeIn});
			});
		}
	}
	function spawnFunny()
	{
		if (FlxG.random.bool(0.02 * theDelta * 60 * (time / 180)))
		{
			var funny:FlxSprite = new FlxSprite();
			funny.loadGraphic(Paths.image('dave'));
			funny.cameras = [camHUD];
			add(funny);

			var funnySound:FlxSound = new FlxSound();
			funnySound = FlxG.sound.load(Paths.sound("dave"));
			funnySound.play();
			new FlxTimer().start(1.25, function(tmr:FlxTimer)
			{
				funny.kill();
			});
		}
	}
}
