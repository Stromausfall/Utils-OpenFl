package net.matthiasauer.utils.misc;

class TypeUtils {
    public static function getAssignableObject<T>(clazz:Class<T>, objects:Array<Dynamic>) : T {
        for (object in objects) {
            if (isAssignable(clazz, object)) {
                return cast object;
            }
        }

        return null;
    }

    public static function isAssignable(clazz:Class<Dynamic>, object:Dynamic) : Bool {
        return Std.instance(object, clazz) != null;
    }
}