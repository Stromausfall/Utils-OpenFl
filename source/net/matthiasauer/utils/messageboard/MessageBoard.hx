package net.matthiasauer.utils.messageboard;

interface MessageBoard {
    function collectFor<T>(topic:String, expectedMessage:Class<T>) : List<T>;
    function store(topic:String, message:Dynamic) : Void;
    function reset() : Void;
}