package uv;

import cpp.Star;

@:semantics(value)
@:include('linc_uv.h')
@:cpp.PointerType({type: 'uv_req_t'})
extern class Req_t {
	var data:Star<cpp.Void>;
}

@:dce
abstract Req(Req_t) from Req_t to Req_t {
	public inline function setData<T>(v:Data<T>)
		this.data = cast v;

	public inline function getData<T>():Data<T>
		return cast this.data;
}
