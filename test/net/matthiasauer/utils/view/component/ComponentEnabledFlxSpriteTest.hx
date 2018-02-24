package net.matthiasauer.utils.view.component;
import net.matthiasauer.utils.collections.Collections;
import haxe.unit.TestCase;
import mockatoo.Mockatoo;
using mockatoo.Mockatoo;

class ComponentEnabledFlxSpriteTest extends TestCase {
    public function testThatTheAddedToMethodIsCalledOnTheComponent() {
        // GIVEN:
        var classUnderTest:ComponentEnabledFlxSprite = new ComponentEnabledFlxSprite();
        var component:Component = Mockatoo.mock(Component);

        // WHEN:
        classUnderTest.registerComponent(component);

        // THEN:
        component.addedTo(classUnderTest).verify(1);

        assertTrue(true);
    }
    
    public function testThatTheRemovedFromMethodIsCalledOnTheComponent() {
        // GIVEN:
        var classUnderTest:ComponentEnabledFlxSprite = new ComponentEnabledFlxSprite();
        var component:Component = Mockatoo.mock(Component);
        classUnderTest.registerComponent(component);

        // WHEN:
        classUnderTest.unregisterComponent(component);

        // THEN:
        component.removedFrom(classUnderTest).verify(1);

        assertTrue(true);
    }
    
    public function testThatComponentsAreUpdatedCorrectly() {
        // GIVEN:
        var elapsedTime:Float = 0.754;
        var classUnderTest:ComponentEnabledFlxSprite = new ComponentEnabledFlxSprite();
        var component1:Component = Mockatoo.mock(Component);
        var component2:Component = Mockatoo.mock(Component);
        classUnderTest.registerComponent(component1);
        classUnderTest.registerComponent(component2);

        // WHEN:
        classUnderTest.update(elapsedTime);

        // THEN:
        component1.update(elapsedTime).verify(1);
        component2.update(elapsedTime).verify(1);

        assertTrue(true);
    }
    
    public function testThatComponentsAreRemovedCorrectly() {
        // GIVEN:
        var elapsedTime:Float = 0.754;
        var classUnderTest:ComponentEnabledFlxSprite = new ComponentEnabledFlxSprite();
        var component1:Component = Mockatoo.mock(Component);
        var component2:Component = Mockatoo.mock(Component);
        classUnderTest.registerComponent(component1);
        classUnderTest.registerComponent(component2);
        classUnderTest.unregisterComponent(component1);

        // WHEN:
        classUnderTest.update(elapsedTime);

        // THEN:
        component1.update(elapsedTime).verify(0);
        component2.update(elapsedTime).verify(1);

        assertTrue(true);
    }
    
    public function testTheGetAllComponentsMethod() {
        // GIVEN:
        var classUnderTest:ComponentEnabledFlxSprite = new ComponentEnabledFlxSprite();
        var component1:Component = Mockatoo.mock(Component);
        var component2:Component = Mockatoo.mock(Component);
        var component3:Component = Mockatoo.mock(Component);
        var component4:Component = Mockatoo.mock(Component);
        classUnderTest.registerComponent(component1);
        classUnderTest.registerComponent(component2);
        classUnderTest.registerComponent(component3);
        classUnderTest.registerComponent(component4);
        classUnderTest.unregisterComponent(component2);
        var expectedComponents:Array<Component> = [component1, component3, component4];

        // WHEN:
        var addedComponents:Array<Component> = classUnderTest.getRegisteredComponents();

        // THEN:
        assertEquals(3, addedComponents.length);
        assertTrue(Collections.iterablesHaveSameContent(addedComponents, expectedComponents));
    }
}

