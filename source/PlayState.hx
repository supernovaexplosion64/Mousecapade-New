package;

import Item;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween.FlxTweenManager;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer.FlxTimerManager;
import flixel.util.FlxTimer;
import haxe.io.Eof;
#if desktop
import Sys;
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
	public var redBars:FlxTypedGroup<FlxBackdrop>;

	public var timers:FlxTimerManager;
	public var tweens:FlxTweenManager;

	var randomX = FlxG.random.int(0, 600);
	var randomY = FlxG.random.int(0, 600);

	public static var score:Int = 0;
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

	public static var time:Float = 0;
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

	public var theDelta:Float;

	var normal_bpm:Float = 173;
	var fast_bpm:Float = 200;
	var slow_bpm:Float = 130;

	var ateThePizza:Bool = false;
	public var maxPizzasEaten:Int = 25;

	public static var paused:Bool = false;

	public var blackScreen:FlxSprite;

	var randomAppear:Float = FlxG.random.float(15, 30);
	var randomAppear2:Float = FlxG.random.float(30, 60);
	var randomAppear3:Float = FlxG.random.float(60, 120);
	var randomAppear4:Float = FlxG.random.float(90, 180);
	var randomAppear5:Float = FlxG.random.float(120, 240);

	var stopCloning:Bool = false;
	var numOfTimes:Int = 0;
	var numClones:Int = 0;
	public var musicPath:String = '';

	override public function create()
	{
		score = 0;
		time = 0;
		blackScreen = new FlxSprite();
		blackScreen.alpha = 0;
		FlxTween.globalManager.active = true;
		paused = false;
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

		camWindow = new FlxCamera();
		camWindow.bgColor.alpha = 0;
		FlxG.cameras.add(camWindow, false);

		camMain = new FlxCamera();
		camMain.bgColor.alpha = 0;
		FlxG.cameras.add(camMain, false);

		if (FlxG.save.data.speedMode)
			musicPath = 'maintheme/alt/';
		else
			musicPath = 'maintheme/';

		FlxG.sound.playMusic(Paths.music(musicPath + 'normal'), 1, true);
		
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

		redBars = new FlxTypedGroup<FlxBackdrop>();
		add(redBars);

		timers = new FlxTimerManager();
		add(timers);

		tweens = new FlxTweenManager();
		add(tweens);

		scoreText = new FlxText();
		scoreText.text = Std.string(score);
		scoreText.setFormat("Times New Roman", 48, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		scoreText.antialiasing = true;
		scoreText.screenCenter(X);
		scoreText.cameras = [camMain];
		add(scoreText);

		timeText = new FlxText();
		timeText.text = Std.string(FlxStringUtil.formatTime(time, true));
		timeText.setFormat("Times New Roman", 48, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		timeText.antialiasing = true;
		timeText.screenCenter(X);
		timeText.y = scoreText.y + scoreText.height + 12;
		timeText.cameras = [camMain];
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
		healthText.text = "Health: " + Std.string(health);
		healthText.setFormat("Times New Roman", 24, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		healthText.antialiasing = true;
		healthText.y = FlxG.height + healthBar.height + 24;
		healthText.cameras = [camMain];
		add(healthText);
		levelText = new FlxText();
		levelText.size = 48;
		levelText.font = "Times New Roman";
		levelText.text = 'LEVEL ' + Std.string(LEVEL);
		levelText.antialiasing = true;
		// levelText.x = 12;
		// levelText.y = 12;
		levelText.cameras = [camHUD];
		// add(levelText);

		blackScreen.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		blackScreen.scrollFactor.set(0, 0);
		blackScreen.alpha = 1;
		blackScreen.cameras = [camWindow];
		add(blackScreen);
		FlxTween.tween(blackScreen, {alpha: 0}, 1);

		new FlxTimer().start(2, function(tmr:FlxTimer)
		{
			FlxTween.tween(levelText, {y: levelText.y * -1}, 1, {ease: FlxEase.backIn});
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				remove(levelText);
			});
		});
		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			blackScreen.kill();
		});
		showNewEnemyText();
		// FlxG.watch.add(player, "x");
		// FlxG.watch.add(player, "y");
	}

	override public function update(elapsed:Float)
	{
		/*cheeses.forEachAlive(function(cheese:Item)
			{
				cheese.scale.set(2, 2);
		});*/
		theDelta = FlxG.elapsed;
		if (paused)
		{
			timers.forEach(function(tmr:FlxTimer)
			{
				if (tmr.active == true)
					tmr.active = false;
			});
			if (FlxTween.globalManager.active == true)
				FlxTween.globalManager.active = false;
		}

		if (!paused)
		{
			timers.forEach(function(tmr:FlxTimer)
			{
				if (tmr.active == false)
					tmr.active = true;
			});
			if (FlxTween.globalManager.active == false)
				FlxTween.globalManager.active = true;
		}
		updateTime();
		FlxG.worldBounds.set(player.x - 100, player.y - 100, 1280, 720);
		if (FlxG.keys.anyJustPressed([ENTER, SPACE]))
		{
			if (FlxG.sound.music != null)
			{
				FlxG.sound.music.pause();
			}
			paused = !paused;
			openSubState(new PauseSubState());
		}
		/*if (time < 0 && health > 0)
		{
			// LEVEL += 1;
			FlxG.resetState();
		}*/
		if (health <= 0)
		{
			FlxG.sound.music.stop();
			// checkFinalScore();
			if (score >= 250000 && !FlxG.save.data.speedUnlocked)
				FlxG.switchState(new UnlockCharacterState());

			if (FlxG.save.data.speedMode)
				FlxG.switchState(new SecretDeathState());
			else
			{
				FlxG.camera.bgColor.alpha = 1;
				camMain.alpha = 1;
				camHUD.alpha = 1;
				FlxG.switchState(new GameOverState());
			}
		}
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
		healthText.text = "Health: " + Std.string(health);
		// showNewEnemyText();
		spawnCheese();
		addNewPizza();
		if (maxPizzasEaten > 0 && health <= 50)
			spawnPizza();
		if (time >= randomAppear)
			spawnWega();
		if (time >= randomAppear5)
			spawnPhone();
		if (time >= randomAppear3)
			spawnScrewed();
		if (time >= randomAppear2)
			spawnFunny();
		if (time >= randomAppear4)
			spawnBFDI();
		// spawnRedBars();
		/*if (health <= 100 && theOtherBar.alpha > 0)
			{
				FlxTween.tween(theOtherBar, {alpha: 0}, 1 / theOtherBar.alpha);
		}*/
		decreasingMultiplier -= 8 * FlxG.elapsed;
		if (decreasingMultiplier < 2)
			decreasingMultiplier = 2;
		player.updateHitbox();
		FlxG.overlap(player, cheeses, playerTouchItem);
		FlxG.overlap(player, pizzas, playerTouchPizza);
		FlxG.overlap(player, wegas, playerTouchWega);
		FlxG.overlap(player, phones, playerTouchPhone);
		FlxG.overlap(player, screweds, playerTouchScrewed);
		FlxG.overlap(player, redBars, playerTouchRedBar);
		if (healthTweening)
			healthEasing();
		#if debug
		if (FlxG.keys.justPressed.SEVEN)
		{
			FlxG.sound.music.stop();
			FlxG.switchState(new SecretDeathState());
		}
		if (FlxG.keys.justPressed.TWO)
		{
			// checkFinalScore();
			FlxG.sound.music.stop();
			FlxG.switchState(new GameOverState());
		}
		if (FlxG.keys.justPressed.SIX)
		{
			FlxG.sound.music.stop();
			FlxG.switchState(new UnlockCharacterState());
		}
		if (FlxG.keys.justPressed.THREE && !FlxG.save.data.speedUnlocked)
		{
			FlxG.save.data.speedUnlocked = true;
		}
		if (FlxG.keys.justPressed.R)
		{
			score = 0;
			FlxG.resetState();
		}
		#end
		// windows.forEachAlive(mouseTouchWindows);
		// windows.forEachExists(mouseTouchWindows);
		super.update(elapsed);
	}

	var stopMusic:Bool = true;
	var stopFastMusic:Bool = false;
	var stopSlowMusic:Bool = false;

	public function changeMusic()
	{
		if (health < 20 && !stopFastMusic)
		{
			FlxG.sound.playMusic(Paths.music(musicPath + 'fast'), 1, true);
			stopFastMusic = !stopFastMusic;
			if (stopMusic)
				stopMusic = !stopMusic;
			if (stopSlowMusic)
				stopSlowMusic = !stopSlowMusic;
		}
		else if (health > 100 && !stopSlowMusic)
		{
			FlxG.sound.playMusic(Paths.music(musicPath + 'slow'), 1, true);
			stopSlowMusic = !stopSlowMusic;
			if (stopMusic)
				stopMusic = !stopMusic;
			if (stopFastMusic)
				stopFastMusic = !stopFastMusic;
		}
		else if (health >= 20 && health <= 100 && !stopMusic)
		{
			FlxG.sound.playMusic(Paths.music(musicPath + 'normal'), 1, true);
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
			makeObjectActive(cheese, 0.3);
		}
	}

	public function spawnPizza()
	{
		var randomChanceToAppear:Float = FlxG.random.float(0.08, 0.24);
		var pizzaAppear:Bool = FlxG.random.bool(randomChanceToAppear * theDelta * 60);
		if (pizzaAppear)
		{
			maxPizzasEaten -= 1;
			var positionX = player.x + FlxG.random.int(-1280, 1280);
			var positionY = player.y + FlxG.random.int(-720, 720);
			var pizza = new Pizza(positionX, positionY);
			// itemScore = cheese.value;
			pizzas.add(pizza);
			pizza.updateHitbox();
			itemTimerPizza(pizza);
			makeObjectActive(pizza, 0.3);
		}
	}

	public function addNewPizza()
	{
		var randomChanceToAppear:Float = FlxG.random.float(0.006, 0.018);
		var chance:Bool = FlxG.random.bool(randomChanceToAppear * theDelta * 60);
		if (chance)
		{
			maxPizzasEaten += 1;
		}
	}

	public function spawnWega()
	{
		var randomChanceToAppear:Float = FlxG.random.float(2, 4);
		var wegaAppear:Bool = FlxG.random.bool(randomChanceToAppear * (time / 45) * theDelta * 60);
		if (wegaAppear)
		{
			var positionX = player.x + FlxG.random.int(-1280, 1280);
			var positionY = player.y + FlxG.random.int(-720, 720);
			var wega = new Wega(positionX, positionY);
			// cheese.cameras = [camGame];
			wegas.add(wega);
			wega.updateHitbox();
			itemTimer(wega);
			wega.active = false;
			makeObjectActive(wega, 0.9);
		}
	}

	public function spawnPhone()
	{
		var randomChanceToAppear:Float = FlxG.random.float(0.4, 0.8);
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
			makeObjectActive(phone, 0.9);
		}
	}
	public function spawnScrewed()
	{
		var randomChanceToAppear:Float = FlxG.random.float(2.2, 3.5);
		var screwedAppear:Bool = FlxG.random.bool(randomChanceToAppear * (time / 90) * theDelta * 60);
		if (screwedAppear)
		{
			var positionX = player.x + FlxG.random.int(-1280, 1280);
			var positionY = player.y + FlxG.random.int(-720, 720);
			var screwed = new Screwed(positionX, positionY);
			// cheese.cameras = [camGame];
			screweds.add(screwed);
			screwed.updateHitbox();
			itemTimer(screwed);
			makeObjectActive(screwed, 0.9);
		}
	}

	public function spawnWindows()
	{
		var randomChanceToAppear:Float = FlxG.random.float(0.7, 0.8);
		var windowsAppear:Bool = FlxG.random.bool(randomChanceToAppear * (time / 120) * theDelta * 60);
		if (windowsAppear)
		{
			var positionX = FlxG.random.int(0, FlxG.width - 100);
			var positionY = FlxG.random.int(0, FlxG.height - 100);
			var window = new WindowsPopUp(positionX, positionY);
			window.setGraphicSize(256, 256);
			window.updateHitbox();
			window.alpha = 0;
			window.cameras = [camHUD];
			windows.add(window);
			FlxTween.tween(window, {alpha: 1}, 0.3);
			itemTimer(window);
		}
	}

	public function spawnRedBars()
	{
		var randomChanceToAppear:Float = FlxG.random.float(0.7, 0.8);
		var redBarAppear:Bool = FlxG.random.bool(randomChanceToAppear * theDelta * 60);
		if (redBarAppear)
		{
			var positionX = FlxG.random.int(0, FlxG.width - 100);
			var positionY = FlxG.random.int(0, FlxG.height - 100);
			var redBar = new FlxBackdrop(Paths.image('redbox'), FlxAxes.X);
			// redBar.x = positionX;
			redBar.y = positionY;
			redBar.alpha = 0.5;
			redBar.active = false;
			FlxTween.tween(redBar, {alpha: 1}, 1.5, {ease: FlxEase.cubeIn});
			FlxTween.tween(redBar.scale, {y: 2.2}, 1.5, {ease: FlxEase.cubeIn});
			var redBarTimer:FlxTimer = new FlxTimer(timers);
			var redBarTimer2:FlxTimer = new FlxTimer(timers);
			var redBarTimer3:FlxTimer = new FlxTimer(timers);
			redBarTimer.start(1.5, function(tmr:FlxTimer)
			{
				FlxTween.tween(redBar.scale, {y: 1.5}, 0.6, {ease: FlxEase.cubeOut});
				redBar.active = true;
			});
			redBarTimer2.start(4.5, function(tmr:FlxTimer)
			{
				FlxTween.tween(redBar.scale, {y: 0}, 2, {ease: FlxEase.cubeIn});
			});
			redBarTimer3.start(6.5, function(tmr:FlxTimer)
			{
				redBar.active = false;
			});
			redBar.updateHitbox();
			redBars.add(redBar);
			itemTimer(redBar, 6.5);
		}
	}

	function spawnBFDI()
	{
		var randomChanceToAppear:Float = FlxG.random.float(0.8, 1);
		if (FlxG.save.data.speedMode)
			randomChanceToAppear = FlxG.random.float(1, 1.2);
		var bfdiAppear:Bool = FlxG.random.bool(randomChanceToAppear * (time / 120) * theDelta * 60);
		if (bfdiAppear)
		{
			var bfdiPopUp:FlxSprite;
			bfdiPopUp = new FlxSprite();
			var daString:String;
			if (FlxG.save.data.speedMode)
			{
				bfdiPopUp.loadGraphic(Paths.image('speed-bfdi'), true, 922, 484);
				bfdiPopUp.animation.add("idle", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13], 24, true);
			}
			else
			{
				bfdiPopUp.loadGraphic(Paths.image('rico-bfdi'), true, 259, 213);
				bfdiPopUp.animation.add("idle", [0, 1, 2, 3, 4, 5, 6, 7], 24, true);
			}
			bfdiPopUp.scale.set(0.6, 0.6);
			if (FlxG.save.data.speedMode)
				bfdiPopUp.scale.set(0.4, 0.4);
			bfdiPopUp.updateHitbox();
			bfdiPopUp.cameras = [camHUD];
			bfdiPopUp.x = FlxG.width;
			bfdiPopUp.y = FlxG.random.int(0, Std.int((FlxG.height - bfdiPopUp.frameHeight) * (1 / bfdiPopUp.scale.y)));
			add(bfdiPopUp);
			bfdiPopUp.animation.play("idle");
			if (FlxG.save.data.speedMode)
			{
				bfdiPopUp.x = bfdiPopUp.frameWidth * -1;
				bfdiPopUp.velocity.x = 220;
			}
			else
			{
				bfdiPopUp.velocity.x = -220;
			}

			itemTimer(bfdiPopUp, 10);
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
		var addYourScore:Int = Std.int(((100 + (bonusStreak * 2)) * itemScore) + decreasingMultiplier);
		return addYourScore;
	}

	public function takeAwayScore():Int
	{
		wegaTimes += 1;
		if (wegaTimes > 50)
			wegaTimes = 50;
		var takeAwayYourScore:Int = 25 + wegaTimes;
		return takeAwayYourScore;
	}

	public function updateScore(type:String)
	{
		if (type == 'add')
		{
			bonusStreak += 1;
			score += addScore();
			var comboText:FlxText = new FlxText(0, 0, 0, "Combo: " + bonusStreak, 20);
			comboText.cameras = [camHUD];
			comboText.font = "Times New Roman";
			comboText.x = scoreText.x + scoreText.width + 24;
			comboText.y = scoreText.y;
			add(comboText);

			var comboAddText:FlxText = new FlxText(0, 0, 0, "+" + addScore(), 20);
			comboAddText.cameras = [camHUD];
			comboAddText.font = "Times New Roman";
			comboAddText.x = scoreText.x + scoreText.width + 24;
			comboAddText.y = comboText.y + comboText.height + 12;
			add(comboAddText);
			FlxTween.tween(comboText, {alpha: 0}, 0.6);
			FlxTween.tween(comboAddText, {alpha: 0}, 0.6);

			#if debug trace("Score addition: " + Std.string(addScore()) + ", Decreasing Multiplier: " + Std.string(decreasingMultiplier)); #end
			decreasingMultiplier = 100 - (2 * wegaTimes);
		}
		if (type == 'take')
		{
			bonusStreak = 0;
			score -= takeAwayScore();
		}
		scoreText.text = Std.string(score);
		scoreText.screenCenter(X);
	}

	public function iAmRunningOutOfNamesToNameMyFunctions()
	{
		if (!healthTweening)
			showHealth();
	}

	public function addHealth(healthGiven:Float = 25)
	{
		health += itemHealthIncrease;
		healthText.text = "Health: " + Std.string(health);
		timerThing = 3;
		if (((health < 100 && !ateThePizza) || (health > 100 && ateThePizza) || (health <= 100 && ateThePizza))
			&& !(health >= 100 && !ateThePizza))
			iAmRunningOutOfNamesToNameMyFunctions();
	}

	public function takeAwayHealth(healthTaken:Float = 5)
	{
		health -= healthTaken;
		healthText.text = "Health: " + Std.string(health);
		timerThing = 3;
		iAmRunningOutOfNamesToNameMyFunctions();
	}

	public function showHealth()
	{
		timerThing = 3;
		healthTweening = true;
		if (healthTweening)
		{
			FlxTween.tween(healthBar, {y: FlxG.height - healthBar.height}, tweeningTime, {ease: FlxEase.backOut});
			FlxTween.tween(theOtherBar, {y: FlxG.height - theOtherBar.height}, tweeningTime, {ease: FlxEase.backOut});
			FlxTween.tween(healthText, {y: FlxG.height - healthBar.height - 36}, tweeningTime, {ease: FlxEase.backOut});
		}
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
				if (healthTweening)
					healthTweening = false;
				stopMyTimer = false;
			});
		};
	}

	function playerTouchItem(player:Player, item:Item)
	{
		if (player.alive && player.exists && item.alive && item.active && item.exists)
		{
			item.kill();
			itemScore = item.value;
			itemHealthIncrease = item.healthIncrease;
			if (health < 100)
				addHealth();
			else
				iAmRunningOutOfNamesToNameMyFunctions();
			updateScore('add');
			if (popUpEnabled)
				showPopUp(Normal);
		}
	}

	function playerTouchPizza(player:Player, item:Pizza)
	{
		if (player.alive && player.exists && item.alive && item.active && item.exists)
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
		if (player.alive && player.exists && item.alive && item.active && item.exists)
		{
			item.kill();
			updateScore('take');
			takeAwayHealth(3);
			if (popUpEnabled)
				showPopUp(Wega);
		}
	}

	function mouseTouchWindows(item:WindowsPopUp)
	{
		if (FlxG.mouse.overlaps(item))
		{
			if (FlxG.mouse.justPressed)
			{
				if (item.alive && item.exists)
				{
					item.kill();
				}
			}
		}
	}

	function playerTouchPhone(player:Player, item:PickUpThePhone)
	{
		if (player.alive && player.exists && item.alive && item.active && item.exists)
		{
			if (FlxG.save.data.speedMode && !stopCloning)
			{
				numOfTimes += 1;
				if (numOfTimes > 25)
					numOfTimes = 25;
				item.kill();
				numClones += 1;
				if (numClones >= 25)
					stopCloning = true;
				var randomSpawned:Int = FlxG.random.int(numOfTimes, 25);
				for (i in 0...randomSpawned)
				{
					var callingTimer:FlxTimer = new FlxTimer(timers);
					callingTimer.start(i * 0.125, function(tmr:FlxTimer)
					{
						var johnPorkIsCalling:FlxSprite = new FlxSprite();
						johnPorkIsCalling.loadGraphic(Paths.image('calling'));
						johnPorkIsCalling.cameras = [camHUD];
						johnPorkIsCalling.x = FlxG.random.int(0, Std.int(FlxG.width - johnPorkIsCalling.width));
						johnPorkIsCalling.y = FlxG.random.int(0, Std.int(FlxG.height - johnPorkIsCalling.height));
						add(johnPorkIsCalling);
						var callingSound:FlxSound = new FlxSound();
						callingSound = FlxG.sound.load(Paths.sound('calling'), 0.4);
						callingSound.play();
						var callingTimer2:FlxTimer = new FlxTimer(timers);
						callingTimer2.start(3, function(tmr:FlxTimer)
						{
							FlxTween.tween(johnPorkIsCalling, {alpha: 0}, 0.6);
							var callingTimer3:FlxTimer = new FlxTimer(timers);
							callingTimer3.start(0.6, function(tmr:FlxTimer)
							{
								johnPorkIsCalling.kill(); // BAD CODING BY IDIOT LOSER RICO
								numClones -= 1;
								if (numClones >= 25)
									stopCloning = true;
								else
									stopCloning = false;
							});
						});
					});
				}
			}
			else
			{
				if (FlxG.random.bool(0.5))
				{
					FlxG.openURL("https://youtu.be/TtQZtBAW08E");
					FlxG.switchState(new MainMenuState());
				}
				else
				{
					var pickUpPhone:FlxSound = new FlxSound();
					pickUpPhone = FlxG.sound.load(Paths.sound("pick-up"));
					pickUpPhone.play();
					item.kill();
					var fnatiPopUp:FlxSprite;
					fnatiPopUp = new FlxSprite();
					fnatiPopUp.loadGraphic(Paths.image('popups/phone'));
					fnatiPopUp.cameras = [camHUD];
					add(fnatiPopUp);
					var fnatiJumpscare:FlxSprite;
					fnatiJumpscare = new FlxSprite();
					fnatiJumpscare.loadGraphic(Paths.image('fnatijumpscare'), true, 800, 450);
					fnatiJumpscare.animation.add("idle", [
						0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 30, 29, 28, 27,
						26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1
					], 60, true);
					fnatiJumpscare.scale.set(FlxG.width / 600, FlxG.height / fnatiJumpscare.frameHeight);
					fnatiJumpscare.cameras = [camHUD];
					fnatiJumpscare.screenCenter();
					var fnatiTimer:FlxTimer = new FlxTimer(timers);
					fnatiTimer.start(1.5, function(tmr:FlxTimer)
					{
						add(fnatiJumpscare);
						fnatiJumpscare.animation.play("idle");
					});
					var fnatiTimer2:FlxTimer = new FlxTimer(timers);
					fnatiTimer2.start(2.3, function(tmr:FlxTimer)
					{
						fnatiPopUp.kill();
						fnatiJumpscare.kill();
					});
				}
			}
		}
	}
	function playerTouchScrewed(player:Player, item:Screwed)
	{
		if (player.alive && player.exists && item.alive && item.active && item.exists)
		{
			item.kill();
			screwed_healthDecrease = item.healthDecrease;
			screwed_daGraphic = item.daGraphic;
			screwed_daScale = item.daScale;
			screwed_daShake = item.daShake;
			screwed_randomMulti = item.randomMulti;
			screwed_alphaAlpha = item.alphaAlpha;
			updateScore('take');
			// if (popUpEnabled)
			shatterScreen();
			var waitTimer:FlxTimer = new FlxTimer(timers);
			waitTimer.start(0.6, function(tmr:FlxTimer)
			{
				takeAwayHealth(screwed_healthDecrease);
			});
		}
	}

	function playerTouchRedBar(player:Player, item:FlxSprite)
	{
		if (player.alive && player.exists && item.alive && item.active && item.exists)
		{
			health -= 3 * FlxG.elapsed;
		}
	}

	function itemTimer(item:FlxSprite, timeTime:Float = 6, alphaTime:Float = 0.6)
	{
		var timerTime:Float = timeTime;
		var daTimer:FlxTimer = new FlxTimer(timers);
		var alphaTimer:FlxTimer = new FlxTimer(timers);
		alphaTimer.start(timerTime, function(tmr:FlxTimer)
		{
			item.active = false;
			item.alpha = 0.5;
		});

		daTimer.start(timerTime + alphaTime, function(tmr:FlxTimer)
		{
			item.kill();
		}, 1);
	}

	function makeObjectActive(item:FlxSprite, timeTime:Float = 1.5)
	{
		item.alpha = 0.5;
		item.active = false;
		var activeTimer:FlxTimer = new FlxTimer(timers);
		activeTimer.start(timeTime, function(tmr:FlxTimer)
		{
			item.alpha = 1;
			item.active = true;
		});
	}

	function itemTimerPizza(item:FlxBasic, timeTime:Float = 30)
	{
		var timerTime:Float = timeTime;
		var daTimer:FlxTimer = new FlxTimer(timers);
		daTimer.start(timerTime, function(tmr:FlxTimer)
		{
			item.kill();
			if (health <= 100)
			{
				ateThePizza = false;
				theOtherBar.alpha = 0;
			}
		});
	}

	function showPopUp(type:PopUp.PopUpType)
	{
		var fallTime:Float = 0.3;
		if (FlxG.save.data.speedMode)
			fallTime += 0.15;
		var popUp:PopUp;
		popUp = new PopUp();
		popUp.getPopUp(type);
		popUp.cameras = [camHUD];
		if (FlxG.save.data.screenShaking)
			add(popUp);
		FlxTween.tween(popUp, {alpha: 0}, fallTime);
		var popUpTimer:FlxTimer = new FlxTimer(timers);
		popUpTimer.start(0.3, function(tmr:FlxTimer)
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
		randomSpeedMulti = screwed_randomMulti;
		// daPhone.angle += 360 * randomSpeedMulti * FlxG.elapsed;
		crack.cameras = [camHUD];
		crack.x = FlxG.random.int(Std.int(crack.width / 2), Std.int(FlxG.width - (crack.width / 2)));
		crack.y = FlxG.random.int(Std.int(crack.height / 2), Std.int(FlxG.height - (crack.height / 2)));
		daPhone.angle = FlxG.random.int(0, 360);
		daPhone.scale.set(0.1, 0.1);
		daPhone.x = crack.x + ((crack.width / 2) - (daPhone.width / 2));
		daPhone.y = crack.y + ((crack.height / 2) - (daPhone.height / 2));
		add(daPhone);
		var daPhoneTimer:FlxTimer = new FlxTimer(timers);
		var daPhoneTimer2:FlxTimer = new FlxTimer(timers);
		var randomTurn = FlxG.random.int(0, 90);
		var breakSound:FlxSound = new FlxSound();
		breakSound = FlxG.sound.load(Paths.sound("phone-break"));
		FlxTween.tween(daPhone.scale, {x: randomSpeedMulti * 0.6, y: randomSpeedMulti * 0.6}, 0.6, {ease: FlxEase.cubeIn});
		FlxTween.tween(daPhone, {angle: daPhone.angle + 1440}, 0.6, {ease: FlxEase.quadIn});
		daPhoneTimer.start(0.6, function(tmr:FlxTimer)
		{
			add(crack);
			breakSound.play();
			if (FlxG.save.data.screenShaking)
				FlxG.camera.shake(screwed_daShake, screwed_daShake);
			FlxTween.tween(daPhone, {y: daPhone.y + (FlxG.height - daPhone.y)}, 4, {ease: FlxEase.cubeIn});
			FlxTween.tween(daPhone, {angle: daPhone.angle + randomTurn}, 4, {ease: FlxEase.cubeIn});
		});
		daPhoneTimer2.start(4, function(tmr:FlxTimer)
		{
			FlxTween.tween(daPhone, {alpha: 0}, 0.6);
		});
	}
	function showNewEnemyText()
	{
		var times:Array<Float> = [randomAppear, randomAppear2, randomAppear3, randomAppear4, randomAppear5];
		var texts:Array<String> = [
			'Wegas have appeared!',
			'THE FUNNY has appeared.',
			'Screwedians have appeared!',
			'BFDI-lings have appeared!',
			'PICK UP THE PHONE PICK UP THE PHONE PICK UP THE PHONE PICK UP THE PHONE'
		];
		var textsAlt:Array<String> = [
			'Ninjas have appeared!',
			'BEN has appeared.',
			'KSIs have appeared!',
			'IShowerSpeed-lings have appeared!',
			'JOHN PORK IS CALLING JOHN PORK IS CALLING JOHN PORK IS CALLING JOHN PORK IS CALLING'
		];
		var sounds:Array<String> = ['scream', 'dave', 'bambi', 'bfdi-scream', 'phone'];
		var soundsAlt:Array<String> = ['ninja', 'ben', 'ksi', 'sparta', 'calling'];
		for (k in 0...times.length)
		{
			var enemyTimer:FlxTimer = new FlxTimer(timers);
			enemyTimer.start(times[k], function(tmr:FlxTimer)
			{
				var newEnemyText:FlxText = new FlxText();
				newEnemyText.text = '';
				newEnemyText.setFormat("Times New Roman", 40, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
				newEnemyText.cameras = [camMain];
				newEnemyText.antialiasing = true;
				newEnemyText.alpha = 0;
				newEnemyText.scale.set(0.2, 0.2);
				if (FlxG.save.data.speedMode)
					newEnemyText.text = textsAlt[k];
				else
					newEnemyText.text = texts[k];
				newEnemyText.x = 0;
				newEnemyText.y = 0;
				newEnemyText.angle = 0;
				add(newEnemyText);
				FlxTween.tween(newEnemyText, {alpha: 1}, 0.3);
				FlxTween.tween(newEnemyText.scale, {x: 1, y: 1}, 0.3, {ease: FlxEase.backOut});
				var enemyTextTween:FlxTimer = new FlxTimer(timers);
				enemyTextTween.start(3, function(tmr:FlxTimer)
				{
					FlxTween.tween(newEnemyText, {angle: 3600}, 5, {ease: FlxEase.cubeIn});
					FlxTween.tween(newEnemyText, {y: FlxG.height * 4}, 5, {ease: FlxEase.cubeIn});
				});
				var appearSound:FlxSound = new FlxSound();
				if (FlxG.save.data.speedMode)
					appearSound = FlxG.sound.load(Paths.sound('appearing/${soundsAlt[k]}'));
				else
					appearSound = FlxG.sound.load(Paths.sound('appearing/${sounds[k]}')); // Is this inefficient? Yes. I'm only doing this because I have two more days until this game releases and I'm a lazy dude
				if (!(FlxG.save.data.speedMode) && sounds[k] != '' || FlxG.save.data.speedMode && soundsAlt[k] != '')
					appearSound.play();
				var killText:FlxTimer = new FlxTimer(timers);
				killText.start(8, function(tmr:FlxTimer)
				{
					if (newEnemyText.exists)
						newEnemyText.kill();
				});
			});
		}
		
	}
	function spawnFunny()
	{
		var daChance:Float = FlxG.random.float(0.025, 0.1);
		var thingThing:String = 'dave';
		var thingThingSound:String = 'dave';
		if (FlxG.save.data.speedMode)
		{
			thingThing = 'popups/speed/ben';
			thingThingSound = 'ben';
		}
		if (FlxG.random.bool(daChance * theDelta * 60 * (time / 120)))
		{
			var funny:FlxSprite = new FlxSprite();
			funny.loadGraphic(Paths.image(thingThing));
			funny.cameras = [camHUD];
			add(funny);

			var funnySound:FlxSound = new FlxSound();
			funnySound = FlxG.sound.load(Paths.sound(thingThingSound));
			funnySound.play();
			FlxTween.tween(funny, {alpha: 0}, 0, {startDelay: 1.25});
			var funnyTimer:FlxTimer = new FlxTimer(timers);
			funnyTimer.start(1.25, function(tmr:FlxTimer)
			{
				funny.alpha = 0;
				funny.kill();
			});
		}
	}
	function checkFinalScore()
	{
		if ((FlxG.save.data.finalScore == null) || (score > FlxG.save.data.finalScore))
		{
			FlxG.save.data.finalScore = score;
			trace("NEW HIGH SCORE: " + score);
		}
	}
}

class PauseSubState extends FlxSubState
{
	public var camPause:FlxCamera;
	public var pauseMusic:FlxSound;

	public function new()
	{
		super();
	}

	override function create()
	{
		camPause = new FlxCamera();
		camPause.bgColor.alpha = 0;
		FlxG.cameras.add(camPause, false);

		super.create();

		var box = new FlxSprite();
		box = new FlxSprite();
		box.makeGraphic(FlxG.width, FlxG.height, 0x80000000);
		box.scrollFactor.set(0, 0);
		box.cameras = [camPause];
		add(box);

		var text = new FlxText(0, 0, 0, "Game Paused");
		text.setFormat("Times New Roman", 80);
		text.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		text.scrollFactor.set(0, 0);
		text.screenCenter(X);
		text.y = FlxG.height * 0.35;
		text.alpha = 0;
		text.cameras = [camPause];
		add(text);

		var text2 = new FlxText(0, 0, 0, "Press Enter or Space to resume game\nPress Escape or Backspace to exit to main menu");
		text2.setFormat("Times New Roman", 64, FlxColor.WHITE, FlxTextAlign.CENTER);
		text2.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		text2.scrollFactor.set(0, 0);
		text2.screenCenter(X);
		text2.y = FlxG.height * 0.5;
		text2.alpha = 0;
		text2.cameras = [camPause];
		add(text2);

		FlxTween.tween(text, {alpha: 1}, 0.6);
		FlxTween.tween(text2, {alpha: 1}, 0.6, {startDelay: 1.2});
		pauseMusic = new FlxSound();
		pauseMusic = FlxG.sound.load(Paths.music('groove-shmoove'), 0, true);
		pauseMusic.play();
		pauseMusic.fadeIn(4, 0, 1);
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.anyJustPressed([ENTER, SPACE]))
		{
			PlayState.paused = !PlayState.paused;
			pauseMusic.stop();
			FlxG.sound.music.resume();
			closeSub();
		}

		if (FlxG.keys.anyJustPressed([ESCAPE, BACKSPACE]))
		{
			FlxG.switchState(new MainMenuState());
		}
	}

	private function closeSub()
	{
		close();
	}
}