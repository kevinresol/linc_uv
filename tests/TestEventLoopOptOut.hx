package;

/**
	With `-D linc_uv_no_eventloop`, the init macro must not attach nativeLoop.
**/
class TestEventLoopOptOut {
	static function main() {
		if (@:privateAccess haxe.EventLoop.main.nativeLoop != null)
			throw "nativeLoop should be null when -D linc_uv_no_eventloop is set";
		trace("ok");
	}
}
