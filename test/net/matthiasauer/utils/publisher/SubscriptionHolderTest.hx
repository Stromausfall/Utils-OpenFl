package net.matthiasauer.utils.publisher;
import haxe.unit.TestCase;

class SubscriptionHolderTest extends TestCase {
    public function testConstructor() {
        // WHEN:
        var subscriptionId:Int = 243;
        var topicId:String = "oioi-testValue";
        var observer:Dynamic->Void = function(foo) {};
        var classUnderTest:SubscriptionHolder = new SubscriptionHolder(subscriptionId, topicId, observer);

        // THEN:
        assertEquals(subscriptionId, classUnderTest.subscriptionId);
        assertEquals(topicId, classUnderTest.topicId);
        assertEquals(observer, classUnderTest.observer);
    }
}
