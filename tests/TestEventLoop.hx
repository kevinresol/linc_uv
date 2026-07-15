package;

import cpp.*;
import uv.*;
import uv.Native.UvHandle;
import uv.Native.UvTimer;

/**
	Smoke: libuv timer driven by `haxe.EventLoop` via `nativeLoop` (RUN_NOWAIT).
**/
class TestEventLoop {
	static var timer:Timer;
	static var fired = false;
	static var closed = false;

	public static function run() {
		if (@:privateAccess haxe.EventLoop.main.nativeLoop == null)
			throw "EventLoop.main.nativeLoop was not auto-registered";

		final loop = Loop.getFromEventLoop(haxe.EventLoop.main);
		if (loop != Loop.DEFAULT)
			throw "main EventLoop should use Loop.DEFAULT";

		timer = new Timer();
		assertOk(timer.init(loop), "timer init");
		assertOk(timer.start(Callable.fromStaticFunction(onTimer), 0, 0), "timer start");

		haxe.EventLoop.main.loop();

		if (!fired)
			throw "timer callback never fired via EventLoop";
		if (!closed)
			throw "timer handle never closed";
	}

	@:unreflective
	static function onTimer(handle:Star<UvTimer>) {
		fired = true;
		final t:Timer = Native.timer(handle);
		assertOk(t.stop(), "timer stop");
		t.asHandle().close(Callable.fromStaticFunction(onClose));
	}

	@:unreflective
	static function onClose(handle:Star<UvHandle>) {
		closed = true;
	}

	static function assertOk(code:Int, what:String) {
		if (code != 0)
			throw '$what failed: $code ${Std.string(Uv.err_name(code))}';
	}
}
