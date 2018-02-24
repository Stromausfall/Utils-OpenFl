package net.matthiasauer.utils.di;
import haxe.unit.TestCase;

interface InterfaceA {    
}

interface InterfaceB {    
}

interface InterfaceC {    
}

interface InterfaceD {    
}

class InterfaceAImplementation implements InterfaceA implements InterfaceC {
    public function new() {
    }
}

class InterfaceBImplementation implements InterfaceB {
    public function new() {
    }
}

class InterfaceDImplementation implements InterfaceD {
    public var interfaceA:InterfaceA;
    public var interfaceB:InterfaceB;

    public function new(interfaceA:InterfaceA, interfaceB:InterfaceB) {
        this.interfaceA = interfaceA;
        this.interfaceB = interfaceB;
    }
}

class InterfaceAImplementationCircular implements InterfaceA {
    public function new(a:InterfaceB) {
    }
}

class InterfaceBImplementationCircular implements InterfaceB {
    public function new(b:InterfaceA) {
    }
}

class ApplicationContextImplTest extends TestCase {
    public function testRetrievingNonExistentImplementation() {
        // GIVEN:
        var classUnderTest:ApplicationContext = new ApplicationContextImpl();

        // WHEN:
        var exceptionMessage:String = null;

        try {
            classUnderTest.getImplementation(InterfaceA);
        } catch(exception:String) {
            exceptionMessage = exception;
        }
        
        // THEN:
        assertEquals("No registered implementation for 'net.matthiasauer.utils.di.InterfaceA'", exceptionMessage);
    }
    
    public function testRetrievingExistingImplementation() {
        // GIVEN:
        var classUnderTest:ApplicationContext = new ApplicationContextImpl();

        // WHEN:
        classUnderTest.addSingleton([InterfaceA], InterfaceAImplementation, []);
        var result:Dynamic = classUnderTest.getImplementation(InterfaceA);
        
        // THEN:
        assertTrue(result != null);
        assertEquals(
            Type.getClassName(InterfaceAImplementation),
            Type.getClassName(Type.getClass(result)));
    }
    
    public function testRetrievingExistingImplementationMultipleTimesReturnsSameInstance() {
        // GIVEN:
        var classUnderTest:ApplicationContext = new ApplicationContextImpl();

        // WHEN:
        classUnderTest.addSingleton([InterfaceA], InterfaceAImplementation, []);
        var result1:InterfaceA = classUnderTest.getImplementation(InterfaceA);
        var result2:InterfaceA = classUnderTest.getImplementation(InterfaceA);
        var result3:InterfaceA = classUnderTest.getImplementation(InterfaceA);
    
        // THEN:
        assertEquals(result1, result2);
        assertEquals(result2, result3);
    }
    
    public function testRetrievingExistingImplementationMultipleTimesReturnsDifferentInstancesForPrototypes() {
        // GIVEN:
        var classUnderTest:ApplicationContext = new ApplicationContextImpl();

        // WHEN:
        classUnderTest.addPrototype([InterfaceA], InterfaceAImplementation, []);
        var result1:InterfaceA = classUnderTest.getImplementation(InterfaceA);
        var result2:InterfaceA = classUnderTest.getImplementation(InterfaceA);
        var result3:InterfaceA = classUnderTest.getImplementation(InterfaceA);
    
        // THEN:
        assertFalse(result1 == result2);
        assertFalse(result1 == result3);
        assertFalse(result2 == result3);
    }
    
    public function testRetrievingImplementationsUsingDifferentInterfaces() {
        // GIVEN:
        var classUnderTest:ApplicationContext = new ApplicationContextImpl();

        // WHEN:
        classUnderTest.addSingleton([InterfaceA, InterfaceC], InterfaceAImplementation, []);
        var result1:InterfaceA = classUnderTest.getImplementation(InterfaceA);
        var result2:InterfaceC = classUnderTest.getImplementation(InterfaceC);
    
        // THEN:
        assertEquals(
            cast(result1, InterfaceAImplementation),
            cast(result2, InterfaceAImplementation));
    }
    
    public function testRetrievingDifferentImplementations() {
        // GIVEN:
        var classUnderTest:ApplicationContext = new ApplicationContextImpl();
        classUnderTest.addSingleton([InterfaceA], InterfaceAImplementation, []);
        classUnderTest.addSingleton([InterfaceB], InterfaceBImplementation, []);

        // WHEN:
        var resultA1:InterfaceA = classUnderTest.getImplementation(InterfaceA);
        var resultB1:InterfaceB = classUnderTest.getImplementation(InterfaceB);
        var resultA2:InterfaceA = classUnderTest.getImplementation(InterfaceA);
        var resultB2:InterfaceB = classUnderTest.getImplementation(InterfaceB);
    
        // THEN:
        assertEquals(Type.getClassName(InterfaceAImplementation), Type.getClassName(Type.getClass(resultA1)));
        assertEquals(Type.getClassName(InterfaceAImplementation), Type.getClassName(Type.getClass(resultA2)));
        assertEquals(Type.getClassName(InterfaceBImplementation), Type.getClassName(Type.getClass(resultB1)));
        assertEquals(Type.getClassName(InterfaceBImplementation), Type.getClassName(Type.getClass(resultB2)));
        assertEquals(resultA1, resultA2);
        assertEquals(resultB1, resultB2);
    }
    
    public function testThatArgumentsAreCorrectlyResolved() {
        // GIVEN:
        var classUnderTest:ApplicationContext = new ApplicationContextImpl();
        classUnderTest.addSingleton([InterfaceA], InterfaceAImplementation, []);
        classUnderTest.addSingleton([InterfaceB], InterfaceBImplementation, []);
        classUnderTest.addSingleton([InterfaceD], InterfaceDImplementation, [InterfaceA, InterfaceB]);

        // WHEN:
        var result:InterfaceD = classUnderTest.getImplementation(InterfaceD);
        var castedResult:InterfaceDImplementation = cast(result, InterfaceDImplementation);
    
        // THEN:
        assertEquals(Type.getClassName(InterfaceAImplementation), Type.getClassName(Type.getClass(castedResult.interfaceA)));
        assertEquals(Type.getClassName(InterfaceBImplementation), Type.getClassName(Type.getClass(castedResult.interfaceB)));
    }

    public function testCircularDependencies() {
        // GIVEN:
        var classUnderTest:ApplicationContext = new ApplicationContextImpl();
        classUnderTest.addSingleton([InterfaceA], InterfaceAImplementationCircular, [InterfaceB]);
        classUnderTest.addSingleton([InterfaceB], InterfaceBImplementationCircular, [InterfaceA]);

        // WHEN:
        var exceptionMessage:String = null;

        try {
            classUnderTest.getImplementation(InterfaceA);
        } catch(exception:String) {
            exceptionMessage = exception;
        }
        
        // THEN:
        assertEquals("Circular Dependency involving 'net.matthiasauer.utils.di.InterfaceAImplementationCircular' detected", exceptionMessage);
    }
    
    public function testThatTheApplicationContextCanBeRetrieved() {
        // GIVEN:
        var classUnderTest:ApplicationContext = new ApplicationContextImpl();

        // WHEN:
        var result:ApplicationContext = classUnderTest.getImplementation(ApplicationContext);
    
        // THEN:
        assertTrue(classUnderTest == result);
    }
}