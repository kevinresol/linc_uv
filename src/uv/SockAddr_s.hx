package uv;

@:semantics(value)
@:include('linc_uv.h')
@:cpp.ValueType({type: 'sockaddr'})
extern class SockAddr_s {
	function new();
}
