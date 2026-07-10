package uv;

import cpp.Star;

@:semantics(value)
@:include('linc_uv.h')
@:cpp.PointerType({type: 'uv_req_t'})
extern class Req_t {
	var data:Star<cpp.Void>;
}
