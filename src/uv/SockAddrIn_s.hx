package uv;

@:semantics(value)
@:include('linc_uv.h')
@:cpp.ValueType({type: 'sockaddr_in'})
extern class SockAddrIn_s {
	function new();
}
