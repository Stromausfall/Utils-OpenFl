package net.matthiasauer.utils.publisher;

class SubscriptionHolder {
    public var topicId(default, null):String;
    public var observer(default, null):Dynamic->Void;
    public var subscriptionId(default, null):Int;

    public function new(subscriptionId:Int, topicId:String, observer:Dynamic->Void) {
        this.topicId = topicId;
        this.observer = observer;
        this.subscriptionId = subscriptionId;
    }
}