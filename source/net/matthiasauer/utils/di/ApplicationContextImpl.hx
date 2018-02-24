package net.matthiasauer.utils.di;
import haxe.ds.GenericStack;

class ApplicationContextImpl implements ApplicationContext {
    private var mappings:Map<String, ApplicationContextStorageElement>;
    private var currentlyCreatedDependencies:GenericStack<String>;

    public function new() {
        this.mappings = new Map<String, ApplicationContextStorageElement>();

        this.addApplicationContextToMappings();
    }

    private function addApplicationContextToMappings() {
        var mappingToThisInstance:ApplicationContextStorageElement = this.createMappingToThisInstance();

        this.addToMapping(ApplicationContext, mappingToThisInstance);
    }

    private function createMappingToThisInstance() {
        var mappingToThisInstance:ApplicationContextStorageElement = new ApplicationContextStorageElement(ApplicationContextImpl, [], DependencyScope.Singleton);
        mappingToThisInstance.instance = this;

        return mappingToThisInstance;
    }

    public function addPrototype(views:Array<Class<Dynamic>>, implementation:Class<Dynamic>, arguments:Array<Class<Dynamic>>) : Void {
        this.add(views, implementation, arguments, DependencyScope.Prototype);
    }

    public function addSingleton(views:Array<Class<Dynamic>>, implementation:Class<Dynamic>, arguments:Array<Class<Dynamic>>) : Void {
        this.add(views, implementation, arguments, DependencyScope.Singleton);
    }

    private function add(views:Array<Class<Dynamic>>, implementation:Class<Dynamic>, arguments:Array<Class<Dynamic>>, scope:DependencyScope) : Void {
        var mapping:ApplicationContextStorageElement = new ApplicationContextStorageElement(implementation, arguments, scope);

        for (view in views) {
            this.addToMapping(view, mapping);
        }
    }

    private function addToMapping(view:Class<Dynamic>, mapping:ApplicationContextStorageElement) : Void {
        var viewKey:String = getIdOf(view);
        this.mappings.set(viewKey, mapping);
    }
    
    private function getIdOf(clazz:Class<Dynamic>) : String {
        return Type.getClassName(clazz);
    }

    public function getImplementation<T>(view:Class<T>) : T {
        this.currentlyCreatedDependencies = new GenericStack<String>();

        return this.getImplementationAndCheckForCircularDependency(view);
    }

    private function getImplementationAndCheckForCircularDependency(view:Class<Dynamic>) : Dynamic {
        var mappingForView:ApplicationContextStorageElement = this.getMappingForView(view);

        if (mappingForView.instance == null) {
            this.createImplementationAndCheckForCircularDependency(mappingForView);
        }

        return getInstanceAndResetIfPrototypeScope(mappingForView);
    }

    private function getInstanceAndResetIfPrototypeScope(mappingForView:ApplicationContextStorageElement) : Dynamic {
        switch(mappingForView.scope) {
            case DependencyScope.Singleton:
                return mappingForView.instance;
            case DependencyScope.Prototype:
                return getInstanceAndReset(mappingForView);
        }
    }

    private function getInstanceAndReset(mappingForView:ApplicationContextStorageElement) : Dynamic {
        var result:Dynamic = mappingForView.instance;

        mappingForView.instance = null;

        return result;
    }

    private function getMappingForView(view:Class<Dynamic>) {
        var viewKey:String = getIdOf(view);
        var mappingForView:ApplicationContextStorageElement = this.mappings.get(viewKey);

        if (mappingForView == null) {
            throw "No registered implementation for '" + Type.getClassName(view) + "'";
        }

        return mappingForView;
    }

    private function createImplementationAndCheckForCircularDependency(mappingForView:ApplicationContextStorageElement) : Void {
        this.preRecursionCircularDependencyCheck(mappingForView.implementationClass);

        this.instantiateImplementationAndAddToMappingForView(mappingForView);

        this.postRecursionCircularDependencyCleanUp();
    }

    private function preRecursionCircularDependencyCheck(implementationClass:Class<Dynamic>) : Void {
        var implementationKey:String = getIdOf(implementationClass);

        this.throwExceptionIfImplementationIsAlreadyBeingInstantiated(implementationKey);

        currentlyCreatedDependencies.add(implementationKey);
    }

    private function postRecursionCircularDependencyCleanUp() : Void {
        currentlyCreatedDependencies.pop();
    }

    private function instantiateImplementationAndAddToMappingForView(mappingForView:ApplicationContextStorageElement) : Void {
        var arguments:Array<Dynamic> = this.getArguments(mappingForView.parameters);

        mappingForView.instance = Type.createInstance(mappingForView.implementationClass, arguments);
    }

    private function throwExceptionIfImplementationIsAlreadyBeingInstantiated(implementationKey:String) : Void {
        for (dependency in this.currentlyCreatedDependencies) {
            if (dependency == implementationKey) {
                throw "Circular Dependency involving '" + implementationKey + "' detected";
            }
        }
    }

    private function getArguments(parameters:Array<Class<Dynamic>>) : Array<Dynamic> {
        var arguments:Array<Dynamic> = [];

        for (parameter in parameters) {
            var argument:Dynamic = this.getImplementationAndCheckForCircularDependency(parameter);
            arguments.push(argument);
        }

        return arguments;
    }
}