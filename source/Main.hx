package;

import flixel.FlxG;
import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;

class Main extends Sprite
{
	public static var fps:FPS;
	
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, StartUpIntro, 144, 144, true));
		#if !mobile
		fps = new FPS(0, 0, 0xFFFFFFFF);
		addChild(fps);
		#end
	}
}
