package uv;

@:semantics(value)
@:include('linc_uv.h')
@:cpp.PointerType({type: 'uv_stream_t'})
extern class Stream_t extends Handle_t {}
