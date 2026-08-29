package;

import Item;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;

class PlayState extends FlxState
{
	public var player:Player;
	public var cheeses:FlxTypedGroup<Item>;

	var randomX = FlxG.random.int(0, 600);
	var randomY = FlxG.random.int(0, 600);

	override public function create()
	{
		FlxG.camera.follow(player, TOPDOWN, 1);
		super.create();
		player = new Player();
		add(player);

		cheeses = new FlxTypedGroup<Item>();
		add(cheeses);

		for (i in 0...50)
		{
			var randomXA = FlxG.random.int(0, 600);
			var randomYA = FlxG.random.int(0, 600);
			var cheese = new Item(randomXA, randomYA);
			cheeses.add(cheese);
		}
	}

	override public function update(elapsed:Float)
	{
		FlxG.overlap(player, cheeses, playerTouchCoin);
		super.update(elapsed);
	}
	function playerTouchCoin(player:Player, item:Item)
	{
		if (player.alive && player.exists && item.alive && item.exists)
		{
			item.kill();
		}
	}
}
