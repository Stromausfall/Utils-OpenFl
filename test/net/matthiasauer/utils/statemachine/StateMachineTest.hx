package net.matthiasauer.utils.statemachine;
import haxe.unit.TestCase;
import net.matthiasauer.utils.di.ApplicationContext;
import mockatoo.Mockatoo;
using mockatoo.Mockatoo;

enum TestStateEnum {
    State1;
    State2;
}

interface TestStateInterface extends StateInterface<TestStateEnum, String> {
    public function foo() : Void;
}

interface TestState1 extends TestStateInterface {
}

interface TestState2 extends TestStateInterface {
}

class TestStateMachine extends StateMachine<TestStateEnum, TestStateInterface, String> {
    public function new(applicationContext:ApplicationContext) {
        super(applicationContext, [TestState1, TestState2]);
    }

    public function foo() : Void {
        this.current.foo();
    }
}

class StateMachineTest extends TestCase {
    public function testThatAllStatesAreCreatedWhenTheStateMachineIsCreated() {
        // GIVEN:
        var dataContext:String = "oioi";
        var mockedApplicationContext:ApplicationContext = Mockatoo.mock(ApplicationContext);
        var mockedState1:TestState1 = Mockatoo.mock(TestState1);
        var mockedState2:TestState2 = Mockatoo.mock(TestState2);
        mockedState1.getState().returns(TestStateEnum.State1);
        mockedState2.getState().returns(TestStateEnum.State2);
        mockedApplicationContext.getImplementation(TestState1).returns(mockedState1);
        mockedApplicationContext.getImplementation(TestState2).returns(mockedState2);

        // WHEN:
        var classUnderTest:TestStateMachine = new TestStateMachine(mockedApplicationContext);

        // THEN:
        mockedApplicationContext.getImplementation(TestState1).verify(1);
        mockedApplicationContext.getImplementation(TestState2).verify(1);

        assertTrue(true);
    }

    public function testThatTheInitializeMethodIsCalledForAllStatesIfTheInitializeMethodIsCalled() {
        // GIVEN:
        var dataContext:String = "oioi";
        var mockedApplicationContext:ApplicationContext = Mockatoo.mock(ApplicationContext);
        var mockedState1:TestState1 = Mockatoo.mock(TestState1);
        var mockedState2:TestState2 = Mockatoo.mock(TestState2);
        mockedState1.getState().returns(TestStateEnum.State1);
        mockedState2.getState().returns(TestStateEnum.State2);
        mockedApplicationContext.getImplementation(TestState1).returns(mockedState1);
        mockedApplicationContext.getImplementation(TestState2).returns(mockedState2);

        // WHEN:
        var classUnderTest:TestStateMachine = new TestStateMachine(mockedApplicationContext);

        // THEN:
        mockedState1.initializeState("oioi").verify(0);
        mockedState2.initializeState("oioi").verify(0);

        // WHEN:
        classUnderTest.initializeStates(TestStateEnum.State1, "oioi");

        // THEN:
        mockedState1.initializeState("oioi").verify(1);
        mockedState2.initializeState("oioi").verify(1);

        assertTrue(true);
    }
    
    public function testThatCallsAreForwardedToTheInitialState() {
        // GIVEN:
        var dataContext:String = "oioi";
        var mockedApplicationContext:ApplicationContext = Mockatoo.mock(ApplicationContext);
        var mockedState1:TestState1 = Mockatoo.mock(TestState1);
        var mockedState2:TestState2 = Mockatoo.mock(TestState2);
        mockedState1.getState().returns(TestStateEnum.State1);
        mockedState2.getState().returns(TestStateEnum.State2);
        mockedApplicationContext.getImplementation(TestState1).returns(mockedState1);
        mockedApplicationContext.getImplementation(TestState2).returns(mockedState2);
        var classUnderTest:TestStateMachine = new TestStateMachine(mockedApplicationContext);
        classUnderTest.initializeStates(TestStateEnum.State1, dataContext);

        // WHEN:
        classUnderTest.foo();

        // THEN:
        mockedState1.foo().verify(1);
        mockedState2.foo().verify(0);

        assertTrue(true);
    }
    
    public function testThatTheEnterStateMethodIsCalledForTheInitialState() {
        // GIVEN:
        var dataContext:String = "oioi";
        var mockedApplicationContext:ApplicationContext = Mockatoo.mock(ApplicationContext);
        var mockedState1:TestState1 = Mockatoo.mock(TestState1);
        var mockedState2:TestState2 = Mockatoo.mock(TestState2);
        mockedState1.getState().returns(TestStateEnum.State1);
        mockedState2.getState().returns(TestStateEnum.State2);
        mockedApplicationContext.getImplementation(TestState1).returns(mockedState1);
        mockedApplicationContext.getImplementation(TestState2).returns(mockedState2);
        var classUnderTest:TestStateMachine = new TestStateMachine(mockedApplicationContext);

        // WHEN:
        classUnderTest.initializeStates(TestStateEnum.State1, dataContext);

        // THEN:
        mockedState1.enterState().verify(1);
        mockedState2.enterState().verify(0);

        assertTrue(true);
    }
    
    public function testThatTheChangeStateMethodChangesTheState() {
        // GIVEN:
        var dataContext:String = "oioi";
        var mockedApplicationContext:ApplicationContext = Mockatoo.mock(ApplicationContext);
        var mockedState1:TestState1 = Mockatoo.mock(TestState1);
        var mockedState2:TestState2 = Mockatoo.mock(TestState2);
        mockedState1.getState().returns(TestStateEnum.State1);
        mockedState2.getState().returns(TestStateEnum.State2);
        mockedApplicationContext.getImplementation(TestState1).returns(mockedState1);
        mockedApplicationContext.getImplementation(TestState2).returns(mockedState2);
        var classUnderTest:TestStateMachine = new TestStateMachine(mockedApplicationContext);
        classUnderTest.initializeStates(TestStateEnum.State1, dataContext);

        // WHEN:
        classUnderTest.changeState(TestStateEnum.State2);
        classUnderTest.foo();

        // THEN:
        mockedState1.foo().verify(0);
        mockedState2.foo().verify(1);

        assertTrue(true);
    }
    
    public function testThatTheChangeStateMethodCallsTheLeaveStateMethodOfThePreviousState() {
        // GIVEN:
        var dataContext:String = "oioi";
        var mockedApplicationContext:ApplicationContext = Mockatoo.mock(ApplicationContext);
        var mockedState1:TestState1 = Mockatoo.mock(TestState1);
        var mockedState2:TestState2 = Mockatoo.mock(TestState2);
        mockedState1.getState().returns(TestStateEnum.State1);
        mockedState2.getState().returns(TestStateEnum.State2);
        mockedApplicationContext.getImplementation(TestState1).returns(mockedState1);
        mockedApplicationContext.getImplementation(TestState2).returns(mockedState2);
        var classUnderTest:TestStateMachine = new TestStateMachine(mockedApplicationContext);
        classUnderTest.initializeStates(TestStateEnum.State1, dataContext);

        // WHEN:
        classUnderTest.changeState(TestStateEnum.State2);
        classUnderTest.foo();

        // THEN:
        mockedState1.leaveState().verify(1);

        mockedState2.enterState().verify(1);
        mockedState2.leaveState().verify(0);

        assertTrue(true);
    }
    
    public function testTheGetStateMethod() {
        // GIVEN:
        var dataContext:String = "oioi";
        var mockedApplicationContext:ApplicationContext = Mockatoo.mock(ApplicationContext);
        var mockedState1:TestState1 = Mockatoo.mock(TestState1);
        var mockedState2:TestState2 = Mockatoo.mock(TestState2);
        mockedState1.getState().returns(TestStateEnum.State1);
        mockedState2.getState().returns(TestStateEnum.State2);
        mockedApplicationContext.getImplementation(TestState1).returns(mockedState1);
        mockedApplicationContext.getImplementation(TestState2).returns(mockedState2);

        // WHEN:
        var classUnderTest:TestStateMachine = new TestStateMachine(mockedApplicationContext);
        classUnderTest.initializeStates(TestStateEnum.State1, dataContext);

        // THEN:
        assertEquals(TestStateEnum.State1, classUnderTest.getState());

        // WHEN:
        classUnderTest.changeState(TestStateEnum.State2);

        // THEN:
        assertEquals(TestStateEnum.State2, classUnderTest.getState());
    }
}
