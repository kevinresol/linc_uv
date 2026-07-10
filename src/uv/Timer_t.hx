package uv;

@:semantics(value)
@:include('linc_uv.h')
@:cpp.PointerType({type: 'uv_timer_t'})
extern class Timer_t extends Handle_t {}
