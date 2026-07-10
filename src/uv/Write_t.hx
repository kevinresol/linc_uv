package uv;

@:semantics(value)
@:include('linc_uv.h')
@:cpp.PointerType({type: 'uv_write_t'})
extern class Write_t extends Req_t {
	var handle:Stream_t;
}
