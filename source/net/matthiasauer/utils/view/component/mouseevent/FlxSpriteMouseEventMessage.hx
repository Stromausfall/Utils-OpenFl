package net.matthiasauer.utils.view.component.mouseevent;
import net.matthiasauer.utils.view.component.ComponentEnabledFlxSprite;

class FlxSpriteMouseEventMessage {
    public var event(default, null):FlxSpriteMouseEvent;
    public var sprite(default, null):ComponentEnabledFlxSprite;

    public function new(sprite:ComponentEnabledFlxSprite, event:FlxSpriteMouseEvent) {
        this.sprite = sprite;
        this.event = event;
    }
}