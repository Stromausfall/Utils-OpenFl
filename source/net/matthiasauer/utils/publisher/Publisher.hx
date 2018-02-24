package net.matthiasauer.utils.publisher;

interface Publisher {
    public function subscribe<T>(topic:Class<T>, observer:T->Void) : Int;
    public function publish<T>(message:T) : Void;
    public function stopSubscription(subscription:Int) : Void;
}