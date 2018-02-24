package net.matthiasauer.utils.statemachine;

interface StateInterface<T, S> {
    public function getState() : T;
    public function initializeState(initializationData : S) : Void;
    public function enterState() : Void;
    public function leaveState() : Void;
}