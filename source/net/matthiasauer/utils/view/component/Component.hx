package net.matthiasauer.utils.view.component;

interface Component {
    public function addedTo(sprite:ComponentEnabledFlxSprite) : Void;
    public function update(elapsed:Float) : Void;
    public function removedFrom(sprite:ComponentEnabledFlxSprite) : Void;
}