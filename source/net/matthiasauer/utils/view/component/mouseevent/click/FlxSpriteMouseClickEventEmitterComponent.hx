package net.matthiasauer.utils.view.component.mouseevent.click;
import net.matthiasauer.utils.publisher.Publisher;
import net.matthiasauer.utils.view.component.mouseevent.click.states.State;

class FlxSpriteMouseClickEventEmitterComponent implements Component {
    private var publisher(default, null):Publisher;
    private var sprite:ComponentEnabledFlxSprite;
    private var state:State;
    private var subscriptionId:Int;

    public function new(publisher:Publisher) {
        this.sprite = null;
        this.state = State.Initial;
        this.publisher = publisher;
        this.subscriptionId = -1;
    }

    public function addedTo(sprite:ComponentEnabledFlxSprite) : Void {
        this.sprite = sprite;
        this.startSubscription();
    }

    private function startSubscription() {
        this.subscriptionId = this.publisher.subscribe(FlxSpriteMouseEventMessage, this.functionProcessMessage);
    }

    public function update(elapsed:Float) : Void {

    }

    public function removedFrom(sprite:ComponentEnabledFlxSprite) : Void {
        this.sprite = null;
        this.state = State.Initial;
        this.stopSubscription();
    }

    private function stopSubscription() {
        this.publisher.stopSubscription(this.subscriptionId);
        this.subscriptionId = -1;
    }

    private function functionProcessMessage(message:FlxSpriteMouseEventMessage) {
        switch(this.state) {
            case State.Initial:
                this.stateInitial(message);
            case State.MouseDown:
                this.stateMouseDown(message);
        }
    }

    private function stateInitial(message:FlxSpriteMouseEventMessage) {
        if (this.shouldStateBeChangedFromInitialToMouseDown(message)) {
            this.state = State.MouseDown;
        } else {
            this.state = State.Initial;
        }
    }
    
    private function shouldStateBeChangedFromInitialToMouseDown(message:FlxSpriteMouseEventMessage) : Bool {
        return this.isOnCorrectSprite(message) && this.isMouseDown(message);
    }

    private function isOnCorrectSprite(message:FlxSpriteMouseEventMessage) : Bool {
        return this.sprite == message.sprite;
    }

    private function isMouseDown(message:FlxSpriteMouseEventMessage) : Bool {
        return FlxSpriteMouseEvent.Down == message.event;
    }

    private function stateMouseDown(message:FlxSpriteMouseEventMessage) {
        if (this.shouldClickEventBeEmitted(message)) {
            this.emitClickEvent();
        }

        this.state = State.Initial;
    }

    private function shouldClickEventBeEmitted(message:FlxSpriteMouseEventMessage) : Bool {
        return this.isOnCorrectSprite(message) && this.isMouseUp(message);
    }

    private function isMouseUp(message:FlxSpriteMouseEventMessage) : Bool {
        return FlxSpriteMouseEvent.Up == message.event;
    }

    private function emitClickEvent() {
        var messageToPublish:FlxSpriteMouseEventMessage =
            new FlxSpriteMouseEventMessage(this.sprite, FlxSpriteMouseEvent.Click);

        this.publisher.publish(messageToPublish);
    }
}
