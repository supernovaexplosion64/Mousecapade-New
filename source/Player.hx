package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

class Player extends FlxSprite
{
    static inline var SPEED:Float = 640;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
        loadGraphic("assets/images/player.png");
		setGraphicSize(128, 128);
		maxVelocity.set(640, 640);
	}
    
    override function update(elapsed:Float)
    {
        updateMovement();
		updateHitbox();
        super.update(elapsed);
    }

    function updateMovement()
	{
		velocity.x = 0;
		velocity.y = 0;
        
        var up:Bool = false;
        var down:Bool = false;
        var left:Bool = false;
        var right:Bool = false;

        up = FlxG.keys.anyPressed([UP, W]);
        down = FlxG.keys.anyPressed([DOWN, S]);
        left = FlxG.keys.anyPressed([LEFT, A]);
        right = FlxG.keys.anyPressed([RIGHT, D]);

        if (up || down || left || right)
		{
			if (up)
				velocity.y = SPEED * -1;
			if (down)
				velocity.y = SPEED;
			if (left)
				velocity.x = SPEED * -1;
			if (right)
				velocity.x = SPEED;
        }
    }
}