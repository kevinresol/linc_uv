package uv;

/**
	Auto-registered via `extraParams.hxml` unless `-D linc_uv_no_eventloop`.
	Wires `Loop.DEFAULT` into `EventLoop.main` via `UvEventLoopDriver`.
**/
#if cpp
class EventLoopHook {
	static function __init__() {
		// Threaded targets assign DEFAULT_DRIVER_FACTORY in EventLoop.__init__.
		// If our __init__ runs first, constructing EventLoop.main would NPE on
		// a null factory — set the Haxe default first, then install UV.
		if (haxe.EventLoop.DEFAULT_DRIVER_FACTORY == null)
			haxe.EventLoop.DEFAULT_DRIVER_FACTORY = _ -> new haxe.HaxeEventLoopDriver();
		Loop.getFromEventLoop(haxe.EventLoop.main);
	}
}
#else
@:dce
class EventLoopHook {}
#end
