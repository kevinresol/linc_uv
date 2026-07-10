package uv;

import uv.Req.Req_t;

@:semantics(value)
@:include('linc_uv.h')
@:cpp.PointerType({type: 'uv_fs_t'})
extern class Fs_t extends Req_t {
	var result:SSizeT;
}

@:dce
abstract Fs(Fs_t) from Fs_t to Fs_t {
	public var result(get, never):Int;

	inline function get_result():Int
		return cast this.result;

	public inline function new()
		this = Alloc.fs();

	@:to public inline function asReq():Req
		return this;
}
