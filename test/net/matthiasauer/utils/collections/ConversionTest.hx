package net.matthiasauer.utils.collections;
import haxe.unit.TestCase;

class ConversionTest extends TestCase {
    public function testIteratorToArray() {
        // GIVEN:
        var map:Map<String, Int> = [
            "one" => 1,
            "two" => 2,
            "three" => 3
        ];

        // WHEN:
        var convertedList:Array<String> = Conversion.iteratorToArray(map.keys());

        // THEN:
        assertEquals(3, convertedList.length);
        
        assertTrue(convertedList.indexOf("one") != -1);
        assertTrue(convertedList.indexOf("two") != -1);
        assertTrue(convertedList.indexOf("three") != -1);
    }
}