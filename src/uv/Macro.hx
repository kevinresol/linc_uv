package uv;

class Macro {
	/**
		Opt-out: `-D linc_uv_no_eventloop` excludes the `uv.EventLoopHook` entry
		point listed in `extraParams.hxml` (Compiler.include only covers packages).
	**/
	public static function setup() {
		#if macro
		if (haxe.macro.Context.defined("linc_uv_no_eventloop"))
			haxe.macro.Compiler.exclude("uv.EventLoopHook");
		#end
	}
}
