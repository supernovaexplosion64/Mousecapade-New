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
		// drag.x = drag.y = 80;
		maxVelocity.set(640, 640);
		// acceleration.y = 200;
		// drag.x = maxVelocity.x * 4;
	}
    
    override function update(elapsed:Float)
    {
        updateMovement();
		updateHitbox();
        super.update(elapsed);
    }

    function updateMovement()
    {
		acceleration.x = 0;
		acceleration.y = 0;

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

		/*if (up && down)
            up = down = false;
        if (left && right)
															left = right = false; */

        if (up || down || left || right)
        {
            var newAngle:Float = 0;
            if (up)
            {
				velocity.y = SPEED * -1;
				// acceleration.y = -maxVelocity.y * 4;
				/*if (left)
                    newAngle -= 45;
                else if (right)
																							newAngle += 45; */
            }
			if (down)
            {
				velocity.y = SPEED;
				// acceleration.y = maxVelocity.y * 4;
				/*if (left)
                    newAngle += 45;
                else if (right)
																							newAngle -= 45; */
            }
			if (left)
			{
				velocity.x = SPEED * -1;
				// acceleration.x = -maxVelocity.x * 4;
			}
			if (right)
			{
				velocity.x = SPEED;
				// acceleration.x = maxVelocity.x * 4;
			}
			// velocity.setPolarDegrees(SPEED, newAngle);
        }
    }
}