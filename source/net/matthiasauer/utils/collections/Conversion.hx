package net.matthiasauer.utils.collections;

class Conversion {
    public static function iteratorToArray<T>(iterator:Iterator<T>) : Array<T> {
        return [for (i in iterator) i];
    }
}