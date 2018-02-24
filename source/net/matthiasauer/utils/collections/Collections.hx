package net.matthiasauer.utils.collections;

class Collections {

    private static function iterablesHaveMatchingContent<T>(iterable1:Iterable<T>, iterable2:Iterable<T>, elementsHaveMatchingContent:T->T->Bool) : Bool {
        var iterable1Copy:Array<T> = Conversion.iteratorToArray(iterable1.iterator());

        var areAllElementsFromIterable2InIterable1:Bool = areAllElementsFromIterable2InArrayAndRemoveIterable2FromArray(iterable1Copy, iterable2, elementsHaveMatchingContent);
        var areAllElementsFromIterable1InIterable2:Bool = isArrayEmpty(iterable1Copy);

        return areAllElementsFromIterable2InIterable1 && areAllElementsFromIterable1InIterable2;
    }

    private static function isArrayEmpty<T>(array:Array<T>) {
        return array.length == 0;
    }

    private static function areAllElementsFromIterable2InArrayAndRemoveIterable2FromArray<T>(array:Array<T>, iterable2:Iterable<T>, elementsHaveMatchingContent:T->T->Bool) : Bool {
        for (element in iterable2) {
            var isElementInIterable1 = removeFirstElementInCollectionMatchingTheElementToMatchAgainst(array, element, elementsHaveMatchingContent);

            if (!isElementInIterable1) {
                return false;
            }
        }

        return true;
    }
    
    private static function removeFirstMatchingElementInCollection<T>(array:Array<T>, elementsHaveMatchingContent:T->Bool) : Bool {
        for (element in array) {
            if (elementsHaveMatchingContent(element)) {
                return array.remove(element);
            }
        }

        return false;
    }

    private static function removeFirstElementInCollectionMatchingTheElementToMatchAgainst<T>(array:Array<T>, elementToMatchAgainst:T, elementsHaveMatchingContent:T->T->Bool) : Bool {
        var argumentMatchesBoundElement:T->Bool = elementsHaveMatchingContent.bind(elementToMatchAgainst);
        var isElementInArray = removeFirstMatchingElementInCollection(array, argumentMatchesBoundElement);

        return isElementInArray;
    }
    
    public static function equalElementExistsInIterable<T:Equatable<T>>(element:T, iterable:Iterable<T>) : Bool {
        return Lambda.exists(iterable, function(elementInIterable) { return element.equals(elementInIterable); });
    }

    public static function iterablesHaveEqualContent<T:Equatable<T>>(iterable1:Iterable<T>, iterable2:Iterable<T>) : Bool {
        var matches:T->T->Bool = function(element1, element2) { return element1.equals(element2); }

        return iterablesHaveMatchingContent(iterable1, iterable2, matches);
    }

    public static function sameElementExistsInIterable<T>(element:T, iterable:Iterable<T>) : Bool {
        return Lambda.exists(iterable, function(elementInIterable) { return element == elementInIterable; });
    }

    public static function iterablesHaveSameContent<T>(iterable1:Iterable<T>, iterable2:Iterable<T>) : Bool {
        var matches:T->T->Bool = function(element1, element2) { return element1 == element2; }

        return iterablesHaveMatchingContent(iterable1, iterable2, matches);
    }
}