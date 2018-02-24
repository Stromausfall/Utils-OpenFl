package net.matthiasauer.utils.view.component;
import net.matthiasauer.utils.collections.Conversion;
import flixel.FlxSprite;

class ComponentEnabledFlxSprite extends FlxSprite {
    private var components:List<Component>;

    public function new() {
        super();

        this.components = new List<Component>();
    }

    public function registerComponent(component:Component) : Void {
        this.components.add(component);

        component.addedTo(this);
    }

    public function unregisterComponent(component:Component) : Void {
        this.components.remove(component);

        component.removedFrom(this);
    }

    override public function update(elapsedTime:Float) : Void {
        super.update(elapsedTime);

        this.updateAllComponents(elapsedTime);
    }

    private function updateAllComponents(elapsedTime:Float) {
        for (component in this.components) {
            component.update(elapsedTime);
        }
    }

    public function getRegisteredComponents() : Array<Component> {
        var registeredComponentsIterator:Iterator<Component> = this.getRegisteredComponentsIterator();
        var registeredComponents:Array<Component> = Conversion.iteratorToArray(registeredComponentsIterator);
        
        return registeredComponents;
    }

    private function getRegisteredComponentsIterator() : Iterator<Component> {
        return this.components.iterator();
    }
}
