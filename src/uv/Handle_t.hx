package uv;

import cpp.Star;

@:semantics(value)
@:include('linc_uv.h')
@:cpp.PointerType({type: 'uv_handle_t'})
extern class Handle_t {
	var data:Star<cpp.Void>;
}
