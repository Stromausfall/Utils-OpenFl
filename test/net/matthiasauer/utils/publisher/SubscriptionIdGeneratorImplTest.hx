package net.matthiasauer.utils.publisher;
import haxe.unit.TestCase;

class SubscriptionIdGeneratorImplTest extends TestCase {
    public function testIdGeneration() {
        // GIVEN:
        var generator:SubscriptionIdGenerator = new SubscriptionIdGeneratorImpl();

        // WHEN:
        var value1:Int = generator.create();
        var value2:Int = generator.create();
        var value3:Int = generator.create();
        var value4:Int = generator.create();
        var value5:Int = generator.create();

        // THEN:
        assertEquals(1, value1);
        assertEquals(2, value2);
        assertEquals(3, value3);
        assertEquals(4, value4);
        assertEquals(5, value5);
    }

    public function testDestroyingAndCreatingIds() {
        // GIVEN:
        var generator:SubscriptionIdGenerator = new SubscriptionIdGeneratorImpl();

        // WHEN:
        var value1:Int = generator.create();
        var value2:Int = generator.create();
        var value3:Int = generator.create();

        // THEN:
        assertEquals(1, value1);
        assertEquals(2, value2);
        assertEquals(3, value3);

        // WHEN:
        generator.destroy(value2);
        var value4:Int = generator.create();
        var value6:Int = generator.create();

        // THEN:
        assertEquals(2, value4);
        assertEquals(4, value6);
    }
}