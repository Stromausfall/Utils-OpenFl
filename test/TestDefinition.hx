package;
import haxe.unit.TestCase;

interface TestDefinition {
    function getTestCases() : Array<TestCase>;
}