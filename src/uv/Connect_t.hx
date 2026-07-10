package uv;

@:semantics(value)
@:include('linc_uv.h')
@:cpp.PointerType({type: 'uv_connect_t'})
extern class Connect_t extends Req_t {
	var handle:Stream_t;
}
