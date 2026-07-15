package uv;

/**
	Auto-registered via `extraParams.hxml` unless `-D linc_uv_no_eventloop`.
	Wires `Loop.DEFAULT` into `EventLoop.main`.
**/
#if cpp
class EventLoopHook {
	static function __init__() {
		Loop.getFromEventLoop(haxe.EventLoop.main);
	}
}
#else
@:dce
class EventLoopHook {}
#end
