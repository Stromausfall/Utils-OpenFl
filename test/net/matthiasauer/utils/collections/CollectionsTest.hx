package net.matthiasauer.utils.collections;

import haxe.unit.TestCase;

class ClassImplementingEquals implements Equatable<ClassImplementingEquals> {
    private var value:String;

    public function new(value:String) {
        this.value = value;
    }

    public function equals(other:ClassImplementingEquals) {
        return this.value == other.value;
    }
}

class CollectionsTest extends TestCase {
    public function testTheEqualElementExistsInIterableMethod() {
        // GIVEN:
        var iterable1:Iterable<ClassImplementingEquals> = [
            new ClassImplementingEquals("foo"),
            new ClassImplementingEquals("bar"),
            new ClassImplementingEquals("foobar")];
        var iterable2:Iterable<ClassImplementingEquals> = [
            new ClassImplementingEquals("fooo"),
            new ClassImplementingEquals("bar"),
            new ClassImplementingEquals("foobar")];
        var elementInIterable1:ClassImplementingEquals = new ClassImplementingEquals("foo");
        var elementInIterable2:ClassImplementingEquals = new ClassImplementingEquals("fooo");

        // EXPECT:
        assertTrue(Collections.equalElementExistsInIterable(elementInIterable1, iterable1));
        assertFalse(Collections.equalElementExistsInIterable(elementInIterable2, iterable1));

        assertTrue(Collections.equalElementExistsInIterable(elementInIterable2, iterable2));
        assertFalse(Collections.equalElementExistsInIterable(elementInIterable1, iterable2));
    }

    public function testTheIterablesHaveEqualContent() {
        // GIVEN:
        var iterable1:Iterable<ClassImplementingEquals> = [
            new ClassImplementingEquals("foo"),
            new ClassImplementingEquals("bar"),
            new ClassImplementingEquals("foobar")];
        var iterable2:Iterable<ClassImplementingEquals> = [
            new ClassImplementingEquals("fooo"),
            new ClassImplementingEquals("bar"),
            new ClassImplementingEquals("foobar")];
        var iterable3:Iterable<ClassImplementingEquals> = [
            new ClassImplementingEquals("fooo"),
            new ClassImplementingEquals("bar"),
            new ClassImplementingEquals("foobar")];
        var iterable4:Iterable<ClassImplementingEquals> = [
            new ClassImplementingEquals("foobar"),
            new ClassImplementingEquals("fooo"),
            new ClassImplementingEquals("bar")];

        // EXPECT:
        assertTrue(Collections.iterablesHaveEqualContent(iterable2, iterable2));
        assertTrue(Collections.iterablesHaveEqualContent(iterable2, iterable3));
        assertTrue(Collections.iterablesHaveEqualContent(iterable2, iterable4));
        
        assertFalse(Collections.iterablesHaveEqualContent(iterable1, iterable2));
        assertFalse(Collections.iterablesHaveEqualContent(iterable1, iterable3));
        assertFalse(Collections.iterablesHaveEqualContent(iterable1, iterable4));
    }

    public function testTheIterablesHaveSameContent() {
        // GIVEN:
        var element1:ClassImplementingEquals = new ClassImplementingEquals("foo");
        var element2:ClassImplementingEquals = new ClassImplementingEquals("foo");
        var element3:ClassImplementingEquals = new ClassImplementingEquals("foo");

        var iterable1:Iterable<ClassImplementingEquals> = [
            element1,
            element2,
            element3];
        var iterable2:Iterable<ClassImplementingEquals> = [
            element3,
            element1,
            element2];
        var iterable3:Iterable<ClassImplementingEquals> = [
            element1,
            new ClassImplementingEquals("foo"),
            element3];

        // EXPECT:
        assertTrue(Collections.iterablesHaveSameContent(iterable1, iterable2));
        assertTrue(Collections.iterablesHaveSameContent(iterable1, iterable1));
        assertTrue(Collections.iterablesHaveSameContent(iterable2, iterable2));
        assertTrue(Collections.iterablesHaveSameContent(iterable3, iterable3));
        
        assertFalse(Collections.iterablesHaveSameContent(iterable1, iterable3));
        assertFalse(Collections.iterablesHaveSameContent(iterable2, iterable3));
    }

    public function testTheIterablesHaveSameContentSpecialCase1() {
        // GIVEN:
        var element1:ClassImplementingEquals = new ClassImplementingEquals("foo");
        var element2:ClassImplementingEquals = new ClassImplementingEquals("foo");

        var iterable1:Iterable<ClassImplementingEquals> = [
            element1,
            element2];
        var iterable2:Iterable<ClassImplementingEquals> = [
            element1,
            element1,
            element2,
            element2];

        // EXPECT:
        assertFalse(Collections.iterablesHaveSameContent(iterable1, iterable2));
    }

    public function testTheIterablesHaveSameContentSpecialCase2() {
        // GIVEN:
        var element1:ClassImplementingEquals = new ClassImplementingEquals("foo");
        var element2:ClassImplementingEquals = new ClassImplementingEquals("foo");

        var iterable1:Iterable<ClassImplementingEquals> = [
            element1,
            element2];
        var iterable2:Iterable<ClassImplementingEquals> = [
            element1,
            element1,
            element2,
            element2];

        // EXPECT:
        assertFalse(Collections.iterablesHaveSameContent(iterable2, iterable1));
    }

    public function testTheIterablesHaveSameContentTestNullValues() {
        // GIVEN:
        var element1:ClassImplementingEquals = new ClassImplementingEquals("foo");
        var element2:ClassImplementingEquals = new ClassImplementingEquals("foo");

        var iterable1:Iterable<ClassImplementingEquals> = [
            element1,
            element2];
        var iterable2:Iterable<ClassImplementingEquals> = [
            element2,
            element1,
            null];
        var iterable3:Iterable<ClassImplementingEquals> = [
            null,
            element1,
            element2];
        var iterable4:Iterable<ClassImplementingEquals> = [
            null,
            element2,
            element1,
            null];

        // EXPECT:
        assertFalse(Collections.iterablesHaveSameContent(iterable1, iterable2));
        assertFalse(Collections.iterablesHaveSameContent(iterable1, iterable2));
        assertFalse(Collections.iterablesHaveSameContent(iterable1, iterable3));
        assertFalse(Collections.iterablesHaveSameContent(iterable1, iterable4));
        
        assertFalse(Collections.iterablesHaveSameContent(iterable2, iterable4));
        
        assertTrue(Collections.iterablesHaveSameContent(iterable2, iterable3));
        assertTrue(Collections.iterablesHaveSameContent(iterable2, iterable2));
        assertTrue(Collections.iterablesHaveSameContent(iterable3, iterable3));
        assertTrue(Collections.iterablesHaveSameContent(iterable4, iterable4));
    }

    public function testTheSameElementExistsInIterableMethod() {
        var elementInIterable1:ClassImplementingEquals = new ClassImplementingEquals("foo");
        var elementInIterable2:ClassImplementingEquals = new ClassImplementingEquals("fooo");
        // GIVEN:
        var iterable1:Iterable<ClassImplementingEquals> = [
            new ClassImplementingEquals("fooo"),
            new ClassImplementingEquals("foo"),
            elementInIterable1];
        var iterable2:Iterable<ClassImplementingEquals> = [
            new ClassImplementingEquals("fooo"),
            new ClassImplementingEquals("foo"),
            elementInIterable2];

        // EXPECT:
        assertTrue(Collections.sameElementExistsInIterable(elementInIterable1, iterable1));
        assertFalse(Collections.sameElementExistsInIterable(elementInIterable2, iterable1));

        assertTrue(Collections.sameElementExistsInIterable(elementInIterable2, iterable2));
        assertFalse(Collections.sameElementExistsInIterable(elementInIterable1, iterable2));
    }
}
