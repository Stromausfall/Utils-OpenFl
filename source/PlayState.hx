package;

import flixel.FlxState;
import net.matthiasauer.utils.di.ApplicationContext;
import net.matthiasauer.utils.di.ApplicationContextImpl;

class PlayState extends FlxState
{
	private function createApplicationContext() : ApplicationContext {
		var applicationContext:ApplicationContext = new ApplicationContextImpl();

		return applicationContext;
	}

	override public function create():Void
	{
		super.create();
		
		var applicationContext:ApplicationContext = this.createApplicationContext();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
