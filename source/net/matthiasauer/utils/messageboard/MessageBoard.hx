package net.matthiasauer.utils.messageboard;

interface MessageBoard {
    function collectFor(topic:String) : List<Dynamic>;
    function store(topic:String, message:Dynamic) : Void;
    function reset() : Void;
}