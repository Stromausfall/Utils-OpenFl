package net.matthiasauer.utils.messageboard;
import haxe.unit.TestCase;
import mockatoo.Mockatoo;
using mockatoo.Mockatoo;

class MessageBoardTest extends TestCase {

    public function testThatIfThereAreNoMessagesForATopicAnEmptyListIsReturned() {
        // GIVEN:
        var messageBoard :MessageBoard = new MessageBoardImpl();

        // WHEN:
        var messagesForNonExistentTopic:List<String> = messageBoard.collectFor("nonExistentTopic", String);

        // THEN:
        assertTrue(messagesForNonExistentTopic.length == 0);
    }

    public function testThatIfMessagesAreAddedToTopicsTheyCanBeRetrieveMultipleTimes() {
        // GIVEN:
        var messageBoard :MessageBoard = new MessageBoardImpl();
        var topic:String = "topic#1";

        // WHEN:
        messageBoard.store(topic, "1");
        messageBoard.store(topic, "2");
        messageBoard.store(topic, "3");
        messageBoard.store(topic, "4");

        var retrievedMessages1:List<String> = messageBoard.collectFor(topic, String);
        var retrievedMessages2:List<String> = messageBoard.collectFor(topic, String);

        // THEN:
        assertTrue(retrievedMessages1.length == 4);
        assertTrue(retrievedMessages2.length == 4);

        assertEquals("1", retrievedMessages1.pop());
        assertEquals("2", retrievedMessages1.pop());
        assertEquals("3", retrievedMessages1.pop());
        assertEquals("4", retrievedMessages1.pop());

        assertEquals("1", retrievedMessages2.pop());
        assertEquals("2", retrievedMessages2.pop());
        assertEquals("3", retrievedMessages2.pop());
        assertEquals("4", retrievedMessages2.pop());
    }

    public function testTheResetMethod() {
        // GIVEN:
        var messageBoard :MessageBoard = new MessageBoardImpl();
        var topic:String = "topic#1";

        // WHEN:
        messageBoard.store(topic, "1");
        messageBoard.store(topic, "2");
        messageBoard.store(topic, "3");
        messageBoard.store(topic, "4");

        // THEN:
        assertEquals(4, messageBoard.collectFor(topic, String).length);

        // WHEN:
        messageBoard.reset();

        // THEN:
        assertEquals(0, messageBoard.collectFor(topic, String).length);
    }
}
