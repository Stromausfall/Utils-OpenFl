package net.matthiasauer.utils.publisher;

interface SubscriptionIdGenerator {
    public function create() : Int;
    public function destroy(value : Int) : Void;
}