package uv;

@:semantics(value)
@:include('linc_uv.h')
@:cpp.PointerType({type: 'uv_shutdown_t'})
extern class Shutdown_t extends Req_t {
	var handle:Stream_t;
}
