package uv;

import cpp.Star;

@:semantics(value)
@:include('linc_uv.h')
@:cpp.PointerType({type: 'uv_loop_t'})
extern class Loop_t {
	var data:Star<cpp.Void>;
}
