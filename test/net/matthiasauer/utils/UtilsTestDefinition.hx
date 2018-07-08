package net.matthiasauer.utils;
import net.matthiasauer.utils.di.ApplicationContextImplTest;
import net.matthiasauer.utils.di.ApplicationContextStorageElementTest;
import net.matthiasauer.utils.publisher.SubscriptionHolderTest;
import net.matthiasauer.utils.publisher.SubscriptionIdGeneratorImplTest;
import net.matthiasauer.utils.publisher.PublisherImplTest;
import net.matthiasauer.utils.collections.ConversionTest;
import net.matthiasauer.utils.collections.CollectionsTest;
import net.matthiasauer.utils.view.component.ComponentEnabledFlxSpriteTest;
import net.matthiasauer.utils.view.component.mouseevent.click.FlxSpriteMouseClickEventEmitterComponentTest;
import net.matthiasauer.utils.statemachine.StateMachineTest;
import net.matthiasauer.utils.messageboard.MessageBoardTest;
import net.matthiasauer.utils.misc.TypeUtilsTest;
import haxe.unit.TestCase;

class UtilsTestDefinition implements TestDefinition {
    public function new() {
    }

    public function getTestCases() : Array<TestCase> {
        return [
            // DI
            new ApplicationContextImplTest(),
            new ApplicationContextStorageElementTest(),

            // Publisher
            new SubscriptionHolderTest(),
            new SubscriptionIdGeneratorImplTest(),
            new PublisherImplTest(),

            // Collections
            new ConversionTest(),
            new CollectionsTest(),

            // View
            new ComponentEnabledFlxSpriteTest(),
            new FlxSpriteMouseClickEventEmitterComponentTest(),

            // StateMachine
            new StateMachineTest(),

            // MessageBoard
            new MessageBoardTest(),

            // Misc
            new TypeUtilsTest()
        ];
    }
}