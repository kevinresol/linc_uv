package uv;

@:semantics(value)
@:include('linc_uv.h')
@:cpp.PointerType({type: 'uv_pipe_t'})
extern class Pipe_t extends Stream_t {}
