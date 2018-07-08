package net.matthiasauer.utils.messageboard;

class MessageBoardImpl implements MessageBoard {
    var messages:Map<String, List<Dynamic>>;
    
    public function new() {
        this.reset();
    }

    function internalCollectFor(topic:String) : List<Dynamic> {
        if (!this.messages.exists(topic)) {
            this.messages.set(topic, new List<Dynamic>());
        }

        return this.messages.get(topic);
    }

    public function collectFor(topic:String) : List<Dynamic> {
        var messagesForTopic = internalCollectFor(topic);

        // return a copy of the list
        return messagesForTopic.filter(function(x) return true);
    }

    public function store(topic:String, message:Dynamic) : Void {
        var messageForTopic = internalCollectFor(topic);

        messageForTopic.add(message);
    }

    public function reset() : Void {
        this.messages = new Map<String, List<Dynamic>>();
    }
}