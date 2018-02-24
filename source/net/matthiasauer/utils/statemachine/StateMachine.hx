package net.matthiasauer.utils.statemachine;
import net.matthiasauer.utils.di.ApplicationContext;

class StateMachine<S, T : StateInterface<S, R>, R> {
    private var applicationContext:ApplicationContext;
    private var current:T;
    private var dataContext:R;
    private var states:Map<String, T>;

    private function new(applicationContext:ApplicationContext, stateClasses:Array<Class<T>>) {
        this.applicationContext = applicationContext;
        this.states = instantiateStates(stateClasses);
    }

    public function initializeStates(initialState:S, dataContext:R) : Void {
        this.dataContext = dataContext;

        for (stateKey in this.states.keys()) {
            var state:T = this.states.get(stateKey);

            state.initializeState(this.dataContext);
        }

        this.changeState(initialState);
    }

    private function instantiateStates(stateClasses:Array<Class<T>>) : Map<String, T> {
        var result:Map<String, T> = new Map<String, T>();

        for (state in stateClasses) {
            var instantiatedState:T = this.instantiate(state);
            var stateKey = this.getStateKeyFromStateInstance(instantiatedState);

            result.set(stateKey, instantiatedState);
        }

        return result;
    }

    private function instantiate(toInstantiate:Class<T>) : T {
        return this.applicationContext.getImplementation(toInstantiate);
    }

    private function getStateKeyFromStateInstance(state:T) : String {
        var stateEnum:S = state.getState();

        return this.getStateKeyFromStateEnum(stateEnum);
    }

    private function getStateKeyFromStateEnum(stateEnum:S) : String {
        return Std.string(stateEnum);
    }

    public function changeState(newStateEnum:S) : Void {
        var newState:T = this.getStateForStateEnum(newStateEnum);

        if (this.current != null) {
            this.current.leaveState();
        }

        this.current = newState;
        this.current.enterState();
    }

    private function getStateForStateEnum(stateEnum:S) : T {
        var stateKey:String = this.getStateKeyFromStateEnum(stateEnum);

        return this.states.get(stateKey);
    }

    public function getState() : S {
        return this.current.getState();
    }
}
