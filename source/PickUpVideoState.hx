package;

import flixel.FlxG;
import flixel.FlxState;
#if ((desktop || android) && !hl)
import hxcodec.flixel.FlxVideo;
#end

class PickUpVideoState extends FlxState
{
    #if ((desktop || android) && !hl)
    var video:FlxVideo = new FlxVideo();
    #end

    override public function create()
    {
    	super.create();

        #if ((desktop || android) && !hl)
        video.play("assets/videos/pick-up-the-phone-new.mp4");
        #end
    }

    override public function update(elapsed:Float)
    {
    	super.update(elapsed);
    }
}