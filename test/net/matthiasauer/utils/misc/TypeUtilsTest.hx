package net.matthiasauer.utils.misc;
import haxe.unit.TestCase;
import mockatoo.Mockatoo;
using mockatoo.Mockatoo;

interface TestTypeUtilsTestAClass {
}

interface TestTypeUtilsTestBClass {
}

class TestTypeUtilsTestCClass implements TestTypeUtilsTestAClass implements TestTypeUtilsTestBClass {
    public function new() {}    
}

class TestTypeUtilsTestDClass {
    public function new() {}
}

class TypeUtilsTest extends TestCase {
    function testThatTheGetAssignableObjectMethodWorksCorrectly1() : Void {
        // WHEN:
        var result:Dynamic = TypeUtils.getAssignableObject(String, [243, true]);

        // THEN:
        assertEquals(null, result);
    }

    function testThatTheGetAssignableObjectMethodWorksCorrectly2() : Void {
        var expectedObject:String = "asdfasdf";

        // WHEN:
        var result:Dynamic = TypeUtils.getAssignableObject(String, [243, true, expectedObject]);

        // THEN:
        assertEquals(expectedObject, result);
    }

    function testThatTheGetAssignableObjectMethodWorksCorrectly3() : Void {
        // WHEN:
        var result:Dynamic = TypeUtils.getAssignableObject(TestTypeUtilsTestAClass, [new TestTypeUtilsTestDClass()]);

        // THEN:
        assertEquals(null, result);
    }

    function testThatTheGetAssignableObjectMethodWorksCorrectly4() : Void {
        var expectedObject:Dynamic = new TestTypeUtilsTestCClass();

        // WHEN:
        var result:Dynamic = TypeUtils.getAssignableObject(TestTypeUtilsTestAClass, [243, new TestTypeUtilsTestDClass(), expectedObject]);

        // THEN:
        assertEquals(expectedObject, result);
    }

    function testThatTheIsAssignableObjectMethodWorksCorrectly() : Void {
        var result:Bool = false;

        // WHEN:
        result = TypeUtils.isAssignable(String, 243);

        // THEN:
        assertFalse(result);
        
        // WHEN:
        result = TypeUtils.isAssignable(String, "asdfasdf");
        
        // THEN:
        assertTrue(result);

        // WHEN:
        result = TypeUtils.isAssignable(TestTypeUtilsTestAClass, new TestTypeUtilsTestDClass());

        // THEN:
        assertFalse(result);

        // WHEN:
        result = TypeUtils.isAssignable(TestTypeUtilsTestAClass, new TestTypeUtilsTestCClass());

        // THEN:
        assertTrue(result);
    }
}