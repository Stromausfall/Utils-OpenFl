package net.matthiasauer.utils.publisher;
import haxe.unit.TestCase;
import mockatoo.Mockatoo;
using mockatoo.Mockatoo;

class PublisherImplTest extends TestCase {
    public function testSimpleSubscribeAndPublish() {
        // GIVEN:
        var initialValue:String = "oi=";
		var value:String = initialValue;
        var publishedValue:String = "2500";
        var classUnderTest:Publisher = new PublisherImpl(new SubscriptionIdGeneratorImpl());

        classUnderTest.subscribe(String, function(input) { value += input; });

        // WHEN:
        classUnderTest.publish(publishedValue);
        
        // THEN:
        assertEquals(initialValue + publishedValue, value);
    }

    public function testMultipleSubscribtionsOnDifferentToptics() {
        // GIVEN:
        var value1:SubscriptionHolder = null;
        var value2:String = null;
        var expectedValue1:SubscriptionHolder = new SubscriptionHolder(0, "", function(sf) {});
        var expectedValue2:String = "oi2";
        var classUnderTest:Publisher = new PublisherImpl(new SubscriptionIdGeneratorImpl());

        classUnderTest.subscribe(SubscriptionHolder, function(input) { value1 = input; });
        classUnderTest.subscribe(String, function(input) { value2 = input; });

        // WHEN:
        classUnderTest.publish(expectedValue1);
        classUnderTest.publish(expectedValue2);
        
        // THEN:
        assertEquals(expectedValue1, value1);
        assertEquals(expectedValue2, value2);
    }

    public function testMultipleSubscribers() {
        // GIVEN:
        var value1:String = "";
        var value2:String = "";
        var publishedValue:String = "2500";
        var classUnderTest:Publisher = new PublisherImpl(new SubscriptionIdGeneratorImpl());

        classUnderTest.subscribe(String, function(input) { value1 += input; });
        classUnderTest.subscribe(String, function(input) { value2 += input; });

        // WHEN:
        classUnderTest.publish(publishedValue);
        
        // THEN:
        assertEquals(publishedValue, value1);
        assertEquals(publishedValue, value2);
    }

    public function testThatTheIdGeneratorIsCalledWhenCreatingASubscription() {
        // GIVEN:
        var id:Int = 999;
        var mockedSubscriptionIdGenerator:SubscriptionIdGenerator = Mockatoo.mock(SubscriptionIdGenerator);
        var classUnderTest:Publisher = new PublisherImpl(mockedSubscriptionIdGenerator);
        mockedSubscriptionIdGenerator.create().returns(id);

        // WHEN:
        var subscriptionId:Int = classUnderTest.subscribe(String, function(input) {});
        
        // THEN:
        mockedSubscriptionIdGenerator.create().verify(1);
        assertEquals(id, subscriptionId);
    }

    public function testStoppingSubscription() {
        // GIVEN:
        var value1:String = "";
        var value2:String = "";
        var publishedValue:String = "2500";
        var mockedSubscriptionIdGenerator:SubscriptionIdGenerator = Mockatoo.mock(SubscriptionIdGenerator);
        var classUnderTest:Publisher = new PublisherImpl(mockedSubscriptionIdGenerator);
        mockedSubscriptionIdGenerator.create().returns(1);
        mockedSubscriptionIdGenerator.create().returns(2);

        var subscription1:Int = classUnderTest.subscribe(String, function(input) { value1 += input; });
        var subscription2:Int = classUnderTest.subscribe(String, function(input) { value2 += input; });

        // WHEN:
        mockedSubscriptionIdGenerator.destroy(2).verify(0);
        classUnderTest.stopSubscription(subscription2);
        mockedSubscriptionIdGenerator.destroy(2).verify(1);
        classUnderTest.publish(publishedValue);
        
        // THEN:
        assertEquals(publishedValue, value1);
        assertEquals("", value2);
    }

    public function testThatOrderingOfPublishedMessagesIsCorrect() {
        // GIVEN:
        var messages:Array<String> = new Array<String>();
        var classUnderTest:Publisher = new PublisherImpl(new SubscriptionIdGeneratorImpl());

        classUnderTest.subscribe(String, function(input) { publishIfOneCharacterString(input, classUnderTest); });
        classUnderTest.subscribe(String, function(input) { collectString(input, messages); });

        // WHEN:
        classUnderTest.publish("1");
        classUnderTest.publish("2");
        classUnderTest.publish("3");
        
        // THEN:
        assertEquals(9, messages.length);

        assertEquals("1", messages[0]);
        assertEquals("1+", messages[1]);
        assertEquals("1++", messages[2]);
        assertEquals("2", messages[3]);
        assertEquals("2+", messages[4]);
        assertEquals("2++", messages[5]);
        assertEquals("3", messages[6]);
        assertEquals("3+", messages[7]);
        assertEquals("3++", messages[8]);
    }

    private function publishIfOneCharacterString(input:String, publisher:Publisher) {
        if (input.length < 3)
        {
            publisher.publish(input + "+");
        } 
    }

    private function collectString(input:String, messages:Array<String>) {
        messages.push(input);
    }
}
