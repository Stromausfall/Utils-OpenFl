package net.matthiasauer.utils.di;

class ApplicationContextStorageElement {
    public var implementationClass(default, null):Class<Dynamic>;
    public var parameters(default, null):Array<Class<Dynamic>>;
    public var instance(default, default):Dynamic;
    public var scope(default, null):DependencyScope;

    public function new(implementationClass:Class<Dynamic>, parameters:Array<Class<Dynamic>>, scope:DependencyScope) {
        this.implementationClass = implementationClass;
        this.parameters = parameters;
        this.instance = null;
        this.scope = scope;
    }
}