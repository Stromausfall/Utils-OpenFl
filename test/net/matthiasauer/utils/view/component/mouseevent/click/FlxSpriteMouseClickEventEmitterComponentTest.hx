package net.matthiasauer.utils.view.component.mouseevent.click;
import net.matthiasauer.utils.view.component.ComponentEnabledFlxSprite;
import net.matthiasauer.utils.publisher.Publisher;
import net.matthiasauer.utils.publisher.PublisherImpl;
import net.matthiasauer.utils.publisher.SubscriptionIdGeneratorImpl;
import haxe.unit.TestCase;
import haxe.ds.GenericStack;
import mockatoo.Mockatoo;
using mockatoo.Mockatoo;

class FlxSpriteMouseClickEventEmitterComponentTest extends TestCase {
    public function testThatACorrectSequenceIsDetected() {
        // GIVEN: 
        var publisher:Publisher = new PublisherImpl(new SubscriptionIdGeneratorImpl());
        var classUnderTest:FlxSpriteMouseClickEventEmitterComponent = new FlxSpriteMouseClickEventEmitterComponent(publisher);
        var sprite:ComponentEnabledFlxSprite = new ComponentEnabledFlxSprite();
        var receivedMessages:Array<FlxSpriteMouseEventMessage> = new Array<FlxSpriteMouseEventMessage>();
        publisher.subscribe(FlxSpriteMouseEventMessage, function(message) { receivedMessages.push(message); });
 
        classUnderTest.addedTo(sprite);

        // WHEN:
        publishMessage(publisher, sprite, FlxSpriteMouseEvent.Down);
        publishMessage(publisher, sprite, FlxSpriteMouseEvent.Up);

        // THEN:
        assertEquals(3, receivedMessages.length);

        assertEquals(FlxSpriteMouseEvent.Down, receivedMessages[0].event);        
        assertEquals(FlxSpriteMouseEvent.Up, receivedMessages[1].event);        
        assertEquals(FlxSpriteMouseEvent.Click, receivedMessages[2].event);
        
        assertEquals(sprite, receivedMessages[0].sprite);
        assertEquals(sprite, receivedMessages[1].sprite);
        assertEquals(sprite, receivedMessages[2].sprite);
    }

    public function testThatIfTheDownAndUpAreNotOnTheSameSpriteNoClickEventIsEmitted1() {
        // GIVEN: 
        var publisher:Publisher = new PublisherImpl(new SubscriptionIdGeneratorImpl());
        var classUnderTest:FlxSpriteMouseClickEventEmitterComponent = new FlxSpriteMouseClickEventEmitterComponent(publisher);
        var sprite:ComponentEnabledFlxSprite = new ComponentEnabledFlxSprite();
        var otherSprite:ComponentEnabledFlxSprite = new ComponentEnabledFlxSprite();
        var receivedMessages:Array<FlxSpriteMouseEventMessage> = new Array<FlxSpriteMouseEventMessage>();
        publisher.subscribe(FlxSpriteMouseEventMessage, function(message) { receivedMessages.push(message); });
 
        classUnderTest.addedTo(sprite);

        // WHEN:
        publishMessage(publisher, sprite, FlxSpriteMouseEvent.Down);
        publishMessage(publisher, otherSprite, FlxSpriteMouseEvent.Up);

        // THEN:
        assertEquals(2, receivedMessages.length);

        assertEquals(FlxSpriteMouseEvent.Down, receivedMessages[0].event);        
        assertEquals(FlxSpriteMouseEvent.Up, receivedMessages[1].event);
        
        assertEquals(sprite, receivedMessages[0].sprite);
        assertEquals(otherSprite, receivedMessages[1].sprite);
    }

    public function testThatOnlyForDownAndUpOnTheSameSpriteAClickEventIsEmitted1() {
        // GIVEN: 
        var publisher:Publisher = new PublisherImpl(new SubscriptionIdGeneratorImpl());
        var classUnderTest:FlxSpriteMouseClickEventEmitterComponent = new FlxSpriteMouseClickEventEmitterComponent(publisher);
        var sprite:ComponentEnabledFlxSprite = new ComponentEnabledFlxSprite();
        var receivedMessages:Array<FlxSpriteMouseEventMessage> = new Array<FlxSpriteMouseEventMessage>();
        publisher.subscribe(FlxSpriteMouseEventMessage, function(message) { receivedMessages.push(message); });
 
        classUnderTest.addedTo(sprite);

        // WHEN:
        publishMessage(publisher, sprite, FlxSpriteMouseEvent.Down);
        publishMessage(publisher, sprite, FlxSpriteMouseEvent.Down);

        // THEN:
        assertEquals(2, receivedMessages.length);

        assertEquals(FlxSpriteMouseEvent.Down, receivedMessages[0].event);        
        assertEquals(FlxSpriteMouseEvent.Down, receivedMessages[1].event);
        
        assertEquals(sprite, receivedMessages[0].sprite);
        assertEquals(sprite, receivedMessages[1].sprite);
    }

    public function testThatOnlyForDownAndUpOnTheSameSpriteAClickEventIsEmitted2() {
        // GIVEN: 
        var publisher:Publisher = new PublisherImpl(new SubscriptionIdGeneratorImpl());
        var classUnderTest:FlxSpriteMouseClickEventEmitterComponent = new FlxSpriteMouseClickEventEmitterComponent(publisher);
        var sprite:ComponentEnabledFlxSprite = new ComponentEnabledFlxSprite();
        var receivedMessages:Array<FlxSpriteMouseEventMessage> = new Array<FlxSpriteMouseEventMessage>();
        publisher.subscribe(FlxSpriteMouseEventMessage, function(message) { receivedMessages.push(message); });
 
        classUnderTest.addedTo(sprite);

        // WHEN:
        publishMessage(publisher, sprite, FlxSpriteMouseEvent.Up);
        publishMessage(publisher, sprite, FlxSpriteMouseEvent.Up);

        // THEN:
        assertEquals(2, receivedMessages.length);

        assertEquals(FlxSpriteMouseEvent.Up, receivedMessages[0].event);        
        assertEquals(FlxSpriteMouseEvent.Up, receivedMessages[1].event);
        
        assertEquals(sprite, receivedMessages[0].sprite);
        assertEquals(sprite, receivedMessages[1].sprite);
    }

    public function testThatIfTheDownAndUpAreNotOnTheSameSpriteNoClickEventIsEmitted2() {
        // GIVEN: 
        var publisher:Publisher = new PublisherImpl(new SubscriptionIdGeneratorImpl());
        var classUnderTest:FlxSpriteMouseClickEventEmitterComponent = new FlxSpriteMouseClickEventEmitterComponent(publisher);
        var sprite:ComponentEnabledFlxSprite = new ComponentEnabledFlxSprite();
        var otherSprite:ComponentEnabledFlxSprite = new ComponentEnabledFlxSprite();
        var receivedMessages:Array<FlxSpriteMouseEventMessage> = new Array<FlxSpriteMouseEventMessage>();
        publisher.subscribe(FlxSpriteMouseEventMessage, function(message) { receivedMessages.push(message); });
 
        classUnderTest.addedTo(sprite);

        // WHEN:
        publishMessage(publisher, otherSprite, FlxSpriteMouseEvent.Down);
        publishMessage(publisher, sprite, FlxSpriteMouseEvent.Up);

        // THEN:
        assertEquals(2, receivedMessages.length);

        assertEquals(FlxSpriteMouseEvent.Down, receivedMessages[0].event);        
        assertEquals(FlxSpriteMouseEvent.Up, receivedMessages[1].event);
        
        assertEquals(otherSprite, receivedMessages[0].sprite);
        assertEquals(sprite, receivedMessages[1].sprite);
    }

    public function testThatIfTheDownAndUpAreNotOnTheSameSpriteNoClickEventIsEmitted3() {
        // GIVEN: 
        var publisher:Publisher = new PublisherImpl(new SubscriptionIdGeneratorImpl());
        var classUnderTest:FlxSpriteMouseClickEventEmitterComponent = new FlxSpriteMouseClickEventEmitterComponent(publisher);
        var sprite:ComponentEnabledFlxSprite = new ComponentEnabledFlxSprite();
        var otherSprite:ComponentEnabledFlxSprite = new ComponentEnabledFlxSprite();
        var receivedMessages:Array<FlxSpriteMouseEventMessage> = new Array<FlxSpriteMouseEventMessage>();
        publisher.subscribe(FlxSpriteMouseEventMessage, function(message) { receivedMessages.push(message); });
 
        classUnderTest.addedTo(sprite);

        // WHEN:
        publishMessage(publisher, otherSprite, FlxSpriteMouseEvent.Down);
        publishMessage(publisher, otherSprite, FlxSpriteMouseEvent.Up);

        // THEN:
        assertEquals(2, receivedMessages.length);

        assertEquals(FlxSpriteMouseEvent.Down, receivedMessages[0].event);        
        assertEquals(FlxSpriteMouseEvent.Up, receivedMessages[1].event);
        
        assertEquals(otherSprite, receivedMessages[0].sprite);
        assertEquals(otherSprite, receivedMessages[1].sprite);
    }

    public function testThatMultipleClicksWorkCorrectly1() {
        // GIVEN: 
        var publisher:Publisher = new PublisherImpl(new SubscriptionIdGeneratorImpl());
        var classUnderTest:FlxSpriteMouseClickEventEmitterComponent = new FlxSpriteMouseClickEventEmitterComponent(publisher);
        var sprite:ComponentEnabledFlxSprite = new ComponentEnabledFlxSprite();
        var receivedMessages:Array<FlxSpriteMouseEventMessage> = new Array<FlxSpriteMouseEventMessage>();
        publisher.subscribe(FlxSpriteMouseEventMessage, function(message) { receivedMessages.push(message); });
 
        classUnderTest.addedTo(sprite);

        // WHEN:
        publishMessage(publisher, sprite, FlxSpriteMouseEvent.Down);
        publishMessage(publisher, sprite, FlxSpriteMouseEvent.Up);
        publishMessage(publisher, sprite, FlxSpriteMouseEvent.Up);

        // THEN:
        assertEquals(4, receivedMessages.length);

        assertEquals(FlxSpriteMouseEvent.Down, receivedMessages[0].event);
        assertEquals(FlxSpriteMouseEvent.Up, receivedMessages[1].event);
        assertEquals(FlxSpriteMouseEvent.Click, receivedMessages[2].event);
        assertEquals(FlxSpriteMouseEvent.Up, receivedMessages[3].event);
        
        assertEquals(sprite, receivedMessages[0].sprite);
        assertEquals(sprite, receivedMessages[1].sprite);
        assertEquals(sprite, receivedMessages[2].sprite);
        assertEquals(sprite, receivedMessages[3].sprite);
    }

    public function testThatMultipleClicksWorkCorrectly2() {
        // GIVEN: 
        var publisher:Publisher = new PublisherImpl(new SubscriptionIdGeneratorImpl());
        var classUnderTest:FlxSpriteMouseClickEventEmitterComponent = new FlxSpriteMouseClickEventEmitterComponent(publisher);
        var sprite:ComponentEnabledFlxSprite = new ComponentEnabledFlxSprite();
        var otherSprite:ComponentEnabledFlxSprite = new ComponentEnabledFlxSprite();
        var receivedMessages:Array<FlxSpriteMouseEventMessage> = new Array<FlxSpriteMouseEventMessage>();
        publisher.subscribe(FlxSpriteMouseEventMessage, function(message) { receivedMessages.push(message); });
 
        classUnderTest.addedTo(sprite);

        // WHEN:
        publishMessage(publisher, sprite, FlxSpriteMouseEvent.Down);
        publishMessage(publisher, sprite, FlxSpriteMouseEvent.Up);
        publishMessage(publisher, otherSprite, FlxSpriteMouseEvent.Up);
        publishMessage(publisher, sprite, FlxSpriteMouseEvent.Down);
        publishMessage(publisher, sprite, FlxSpriteMouseEvent.Up);

        // THEN:
        assertEquals(7, receivedMessages.length);

        assertEquals(FlxSpriteMouseEvent.Down, receivedMessages[0].event);
        assertEquals(FlxSpriteMouseEvent.Up, receivedMessages[1].event);
        assertEquals(FlxSpriteMouseEvent.Click, receivedMessages[2].event);
        assertEquals(FlxSpriteMouseEvent.Up, receivedMessages[3].event);
        assertEquals(FlxSpriteMouseEvent.Down, receivedMessages[4].event);
        assertEquals(FlxSpriteMouseEvent.Up, receivedMessages[5].event);
        assertEquals(FlxSpriteMouseEvent.Click, receivedMessages[6].event);
        
        assertEquals(sprite, receivedMessages[0].sprite);
        assertEquals(sprite, receivedMessages[1].sprite);
        assertEquals(sprite, receivedMessages[2].sprite);
        assertEquals(otherSprite, receivedMessages[3].sprite);
        assertEquals(sprite, receivedMessages[4].sprite);
        assertEquals(sprite, receivedMessages[5].sprite);
        assertEquals(sprite, receivedMessages[6].sprite);
    }

    public function testThatMultipleClicksWorkCorrectly3() {
        // GIVEN: 
        var publisher:Publisher = new PublisherImpl(new SubscriptionIdGeneratorImpl());
        var classUnderTest:FlxSpriteMouseClickEventEmitterComponent = new FlxSpriteMouseClickEventEmitterComponent(publisher);
        var sprite:ComponentEnabledFlxSprite = new ComponentEnabledFlxSprite();
        var otherSprite:ComponentEnabledFlxSprite = new ComponentEnabledFlxSprite();
        var receivedMessages:Array<FlxSpriteMouseEventMessage> = new Array<FlxSpriteMouseEventMessage>();
        publisher.subscribe(FlxSpriteMouseEventMessage, function(message) { receivedMessages.push(message); });
 
        classUnderTest.addedTo(sprite);

        // WHEN:
        publishMessage(publisher, sprite, FlxSpriteMouseEvent.Down);
        publishMessage(publisher, sprite, FlxSpriteMouseEvent.Up);
        publishMessage(publisher, sprite, FlxSpriteMouseEvent.Down);
        publishMessage(publisher, sprite, FlxSpriteMouseEvent.Up);

        // THEN:
        assertEquals(6, receivedMessages.length);

        assertEquals(FlxSpriteMouseEvent.Down, receivedMessages[0].event);
        assertEquals(FlxSpriteMouseEvent.Up, receivedMessages[1].event);
        assertEquals(FlxSpriteMouseEvent.Click, receivedMessages[2].event);
        assertEquals(FlxSpriteMouseEvent.Down, receivedMessages[3].event);
        assertEquals(FlxSpriteMouseEvent.Up, receivedMessages[4].event);
        assertEquals(FlxSpriteMouseEvent.Click, receivedMessages[5].event);
        
        assertEquals(sprite, receivedMessages[0].sprite);
        assertEquals(sprite, receivedMessages[1].sprite);
        assertEquals(sprite, receivedMessages[2].sprite);
        assertEquals(sprite, receivedMessages[3].sprite);
        assertEquals(sprite, receivedMessages[4].sprite);
        assertEquals(sprite, receivedMessages[5].sprite);
    }

    public function testThatRemovingFromSpriteWorksCorrectly() {
        // GIVEN: 
        var publisher:Publisher = new PublisherImpl(new SubscriptionIdGeneratorImpl());
        var classUnderTest:FlxSpriteMouseClickEventEmitterComponent = new FlxSpriteMouseClickEventEmitterComponent(publisher);
        var sprite:ComponentEnabledFlxSprite = new ComponentEnabledFlxSprite();
        var receivedMessages:Array<FlxSpriteMouseEventMessage> = new Array<FlxSpriteMouseEventMessage>();
        publisher.subscribe(FlxSpriteMouseEventMessage, function(message) { receivedMessages.push(message); });
 
        classUnderTest.addedTo(sprite);
        classUnderTest.removedFrom(sprite);

        // WHEN:
        publishMessage(publisher, sprite, FlxSpriteMouseEvent.Down);
        publishMessage(publisher, sprite, FlxSpriteMouseEvent.Up);

        // THEN:
        assertEquals(2, receivedMessages.length);

        assertEquals(FlxSpriteMouseEvent.Down, receivedMessages[0].event);        
        assertEquals(FlxSpriteMouseEvent.Up, receivedMessages[1].event);
        
        assertEquals(sprite, receivedMessages[0].sprite);
        assertEquals(sprite, receivedMessages[1].sprite);
    }

    private function publishMessage(publisher:Publisher, sprite:ComponentEnabledFlxSprite, event:FlxSpriteMouseEvent) {
        var message:FlxSpriteMouseEventMessage =
            new FlxSpriteMouseEventMessage(sprite, event);

        publisher.publish(message);
    }
}