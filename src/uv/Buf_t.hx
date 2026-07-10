package uv;

import cpp.*;

@:semantics(value)
@:include('linc_uv.h')
@:cpp.ValueType({type: 'uv_buf_t'})
extern class Buf_t {
	var base:CastCharStar;
	var len:SizeT;
	function new();
}
