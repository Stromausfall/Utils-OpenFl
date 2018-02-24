package net.matthiasauer.utils.publisher;

class PublisherImpl implements Publisher {
    private var subscriptionHolders:List<SubscriptionHolder>;
    private var idGenerator:SubscriptionIdGenerator;
    private var currentlyPublishing:Bool;
    private var messagesToPublish:List<Dynamic>;

    public function new(idGenerator:SubscriptionIdGenerator) {
        this.subscriptionHolders = new List<SubscriptionHolder>();
        this.idGenerator = idGenerator;
        this.currentlyPublishing = false;
        this.messagesToPublish = new List<Dynamic>();
    }

    public function subscribe<T>(topic:Class<T>, observer:T->Void) : Int {
        var subscriptionHolder:SubscriptionHolder = this.createSubscriptionHolder(topic, observer);

        this.subscriptionHolders.add(subscriptionHolder);

        return subscriptionHolder.subscriptionId;
    }

    private function createSubscriptionHolder<T>(topic:Class<T>, observer:T->Void) : SubscriptionHolder {
        var subscriptionId:Int = this.idGenerator.create();
        var topicId:String = getIdOf(topic);

        return new SubscriptionHolder(subscriptionId, topicId, observer);
    }
    
    private function getIdOf(clazz:Class<Dynamic>) : String {
        return Type.getClassName(clazz);
    }

    public function publish<T>(message:T) : Void {
        this.messagesToPublish.add(message);

        this.publishMessagesIfNecessary();
    }

    public function publishMessagesIfNecessary() {
        if (this.firstInCallStackToCallPublish()) {
            currentlyPublishing = true;
            this.processMessages();
            currentlyPublishing = false;
        }
    }

    private function firstInCallStackToCallPublish() {
        return !currentlyPublishing;
    }

    private function processMessages() {
        while (!this.messagesToPublish.isEmpty()) {
            var messageToPublish:Dynamic = this.messagesToPublish.pop();

            this.publishMessage(messageToPublish);
        }
    }

    private function publishMessage<T>(messageToPublish:T) : Void {
        var topicId:String = getTopicId(messageToPublish);
        var observers:List<Dynamic->Void> = this.getObserversOnTopic(topicId);

        for (observer in observers) {
            observer(messageToPublish);
        }
    }

    private function getTopicId<T>(message:T) : String {
        var topic:Class<Dynamic> = Type.getClass(message);

        return getIdOf(topic);
    }

    private function getObserversOnTopic(topicId:String) : List<Dynamic->Void> {
        var observers:List<Dynamic->Void> = new List<Dynamic->Void>();

        for (subscriptionHolder in this.subscriptionHolders) {
            if (subscriptionHolder.topicId == topicId) {
                observers.add(subscriptionHolder.observer);
            }
        }

        return observers;
    }

    public function stopSubscription(subscriptionToStop:Int) : Void {
        this.idGenerator.destroy(subscriptionToStop);
        var subscriptionHoldersToStop:List<SubscriptionHolder> = this.getSubscriptionHoldersWith(subscriptionToStop);

        for (subscriptionToStop in subscriptionHoldersToStop) {
            this.subscriptionHolders.remove(subscriptionToStop);
        }
    }

    private function getSubscriptionHoldersWith(subscriptionIdToRetrieve:Int) : List<SubscriptionHolder> {
        var result:List<SubscriptionHolder> = new List<SubscriptionHolder>();

        for (subscriptionHolder in this.subscriptionHolders) {
            if (isMatchingSubscriptionHolder(subscriptionHolder, subscriptionIdToRetrieve)) {
                result.add(subscriptionHolder);
            }
        }

        return result;
    }

    private function isMatchingSubscriptionHolder(subscriptionHolder:SubscriptionHolder, subscriptionIdToMatch:Int) : Bool {
            var subscriptionId:Int = subscriptionHolder.subscriptionId;

            return subscriptionId == subscriptionIdToMatch;
    }
}