import haxe.CallStack.StackItem;

@:publicFields
class Paths {
    static inline function item(k:String):String
        return 'assets/images/items/$k.png';
	static inline function enemy(k:String):String
		return 'assets/images/enemies/$k.png';
	static inline function image(k:String):String
		return 'assets/images/$k.png';

	static inline function music(k:String):String
	{
		var outputSuffix:String;
		#if desktop
		outputSuffix = '.ogg';
		#else
		outputSuffix = '.mp3';
		#end
		return 'assets/music/$k' + outputSuffix;
	}

	static inline function sound(k:String):String
	{
		var outputSuffix:String;
		#if desktop
		outputSuffix = '.ogg';
		#else
		outputSuffix = '.mp3';
		#end
		return 'assets/sounds/$k' + outputSuffix;
	}
	static inline function video(k:String):String
		return 'assets/videos/$k.png';
}