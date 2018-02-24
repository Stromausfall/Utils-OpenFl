package net.matthiasauer.utils.di;

interface ApplicationContext {
    public function addSingleton(views:Array<Class<Dynamic>>, implementation:Class<Dynamic>, arguments:Array<Class<Dynamic>>) : Void;
    public function addPrototype(views:Array<Class<Dynamic>>, implementation:Class<Dynamic>, arguments:Array<Class<Dynamic>>) : Void;
    public function getImplementation<T>(view:Class<T>) : T;
}
