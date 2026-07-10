package uv;

@:semantics(value)
@:include('linc_uv.h')
@:cpp.PointerType({type: 'uv_tcp_t'})
extern class Tcp_t extends Stream_t {}
