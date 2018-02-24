package net.matthiasauer.utils.view.component.mouseevent;
import flixel.FlxSprite;
import flixel.input.mouse.FlxMouseEventManager;
import net.matthiasauer.utils.publisher.Publisher;

class FlxSpriteMouseEventEmitterComponent implements Component {
    private var publisher:Publisher;
    private var sprite:ComponentEnabledFlxSprite;

    public function new(publisher:Publisher) {
        this.publisher = publisher;
    }

    public function addedTo(sprite:ComponentEnabledFlxSprite) : Void {
        this.sprite = sprite;

        FlxMouseEventManager.add(this.sprite, onMouseDown, onMouseUp, onMouseOver, onMouseOut);
    }

    public function update(elapsed:Float) : Void {

    }

    public function removedFrom(sprite:ComponentEnabledFlxSprite) : Void {
        FlxMouseEventManager.remove(sprite);
    }

    private function publishMessage(event:FlxSpriteMouseEvent) {
        var message:FlxSpriteMouseEventMessage =
            new FlxSpriteMouseEventMessage(this.sprite, event);

        this.publisher.publish(message);
    }

	private function onMouseDown(sprite:FlxSprite) {
        this.publishMessage(FlxSpriteMouseEvent.Down);
    }

    private function onMouseUp(sprite:FlxSprite) {
        this.publishMessage(FlxSpriteMouseEvent.Up);
    }

    private function onMouseOver(sprite:FlxSprite) {
        this.publishMessage(FlxSpriteMouseEvent.Over);
    }

    private function onMouseOut(sprite:FlxSprite) {
        this.publishMessage(FlxSpriteMouseEvent.Out);
    }

//    "down" then "up" without "out" !!!
}
