package;
import haxe.unit.TestCase;
import haxe.unit.TestRunner;
import openfl.display.Sprite;
import net.matthiasauer.utils.UtilsTestDefinition;

class TestMain {
    private static function getTestCases():Array<TestCase> {
        var testCases:Array<TestCase> = [];

        testCases = testCases.concat(new UtilsTestDefinition().getTestCases());

        return testCases;
    }

    private static function executeTests() {
        var runner:TestRunner = new TestRunner();
        var tests:Array<TestCase> = getTestCases();

        // add all the tests to run
        for (test in tests) {
            runner.add(test);
        }

        runner.run();
    }

    public static function main() {
        executeTests();
    }
}