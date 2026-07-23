package;

/**
	With `-D linc_uv_no_eventloop`, the init macro must not install UvEventLoopDriver.
**/
class TestEventLoopOptOut {
	static function main() {
		if (Std.isOfType(haxe.EventLoop.main.getDriver(), uv.UvEventLoopDriver))
			throw "UvEventLoopDriver should not be installed when -D linc_uv_no_eventloop is set";
		trace("ok");
	}
}
