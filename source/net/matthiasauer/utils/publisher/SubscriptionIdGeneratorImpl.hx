package net.matthiasauer.utils.publisher;
import haxe.ds.GenericStack;

class SubscriptionIdGeneratorImpl implements SubscriptionIdGenerator {
    private var currentId:Int;
    private var returnedIds:GenericStack<Int>;

    public function new() {
        this.currentId = 0;
        this.returnedIds = new GenericStack<Int>();
    }

    public function create() : Int {
        if (this.canUseReturnedId()) {
            return this.getReturnedId();
        } else {
            return this.getNewId();
        }
    }

    private function canUseReturnedId() : Bool {
        return !this.returnedIds.isEmpty();
    }

    private function getReturnedId() : Int {
        return this.returnedIds.pop();
    }

    private function getNewId() : Int {
        currentId += 1;

        return currentId;
    }

    public function destroy(value : Int) : Void {
        this.returnedIds.add(value);
    }
}