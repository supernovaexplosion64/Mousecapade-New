package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class WarningState extends FlxState
{
    var warningText:FlxText;
    var warningText2:FlxText;
    var warningText3:FlxText;

    var button:FlxSprite;
    var button2:FlxSprite;
    var buttonText:FlxText;
    var buttonText2:FlxText;

    var delayDelay:Float = 0.6;

    override public function create()
    {
    	super.create();

        warningText = new FlxText(0, 0, FlxG.width - 12);
        warningText.text = 'WARNING!';
        warningText.setFormat("Times New Roman", 80, FlxColor.RED, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, 0xFF800000);
        warningText.size = 80;
        warningText.screenCenter(X);
        warningText.y = warningText.height * -1;
        add(warningText);

        warningText2 = new FlxText(0, 0, FlxG.width - 12);
        warningText2.text = 'This game contains flashing lights and bright colors/imagery that may trigger photosensitive epileptic seizures.\nWould like to turn off screen shaking and flashing imagery in this game?';
        warningText2.setFormat("Times New Roman", 36, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.GRAY);
        warningText2.screenCenter(X);
        warningText2.y = warningText2.height * -1;
        add(warningText2);

        button = new FlxSprite();
        button.makeGraphic(400, 150, FlxColor.LIME);
        button.x = (FlxG.width / 2) - button.width - 12;
        button.y = (FlxG.height / 2) + 12;
        add(button);

        button2 = new FlxSprite();
        button2.makeGraphic(400, 150, FlxColor.RED);
        button2.screenCenter(X);
        button2.x = (FlxG.width / 2) + 12;
        button2.y = button.y;
        add(button2);

        buttonText = new FlxText(0, 0, button.width);
        buttonText.text = 'Yes, turn off screen shaking and flashing lights.';
        buttonText.setFormat("Times New Roman", 24, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        buttonText.x = button.x + (button.width / 2) - (buttonText.width / 2);
        buttonText.y = button.y + (button.height / 2) - (buttonText.height / 2);
        add(buttonText);

        buttonText2 = new FlxText(0, 0, button2.width);
        buttonText2.text = 'No, keep screen shaking and flashing lights on.';
        buttonText2.setFormat("Times New Roman", 24, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        buttonText2.x = button2.x + (button2.width / 2) - (buttonText2.width / 2);
        buttonText2.y = button2.y + (button2.height / 2) - (buttonText2.height / 2);
        add(buttonText2);

        #if desktop
        delayDelay += 2;
        #end

        for (j in [button, button2, buttonText, buttonText2])
        {
            j.alpha = 0;
            FlxTween.tween(j, {alpha: 1}, 0.6, {ease: FlxEase.cubeOut, startDelay: delayDelay + 6.6});
        }

        FlxTween.tween(warningText, {y: 64}, 1.6, {ease: FlxEase.cubeOut, startDelay: delayDelay});
        FlxTween.tween(warningText2, {y: 64 + warningText.height + 12}, 1.6, {ease: FlxEase.cubeOut, startDelay: delayDelay + 2.6});
    }

    override public function update(elapsed:Float)
    {
    	super.update(elapsed);

        if (FlxG.mouse.overlaps(button))
        {
            for (e in [button, buttonText])
            {
                FlxTween.tween(e, {alpha: 0.6}, 0.6);
            }

            if (FlxG.mouse.justPressed)
            {
                FlxG.save.data.screenShaking = false;
                FlxG.switchState(new MainMenuState());
            }
        }
        else
        {
            if (button.alpha < 1)
            {
                for (e in [button, buttonText])
                {
                    FlxTween.tween(e, {alpha: 1}, 0.6);
                }
            }
        }

        if (FlxG.mouse.overlaps(button2))
        {
            for (e in [button2, buttonText2])
            {
                FlxTween.tween(e, {alpha: 0.6}, 0.6);
            }

            if (FlxG.mouse.justPressed)
            {
                FlxG.save.data.screenShaking = true;
                FlxG.switchState(new MainMenuState());
            }
        }
        else
        {
            if (button2.alpha < 1)
            {
                for (e in [button2, buttonText2])
                {
                    FlxTween.tween(e, {alpha: 1}, 0.6);
                }
            }
        }
    }
}