package net.matthiasauer.utils.di;
import haxe.unit.TestCase;

class ApplicationContextStorageElementTest extends TestCase {
    public function testConstructor() {
        // WHEN:
        var classUnderTest:ApplicationContextStorageElement = new ApplicationContextStorageElement(ApplicationContext, [ApplicationContextStorageElementTest, ApplicationMain], DependencyScope.Prototype);

        // THEN:
        assertEquals(
            Type.getClassName(ApplicationContext),
            Type.getClassName(classUnderTest.implementationClass));

        assertEquals(
            Type.getClassName(ApplicationContextStorageElementTest),
            Type.getClassName(classUnderTest.parameters[0]));
        assertEquals(
            Type.getClassName(ApplicationMain),
            Type.getClassName(classUnderTest.parameters[1]));
        assertEquals(DependencyScope.Prototype, classUnderTest.scope);

        assertEquals(null, classUnderTest.instance);
    }

    public function testSetter() {
        // GIVEN:
        var classUnderTest:ApplicationContextStorageElement = new ApplicationContextStorageElement(ApplicationContext, [], DependencyScope.Singleton);

        // WHEN:
        classUnderTest.instance = 243.50;

        // THEN:
        assertEquals(243.50, classUnderTest.instance);
    }
}
