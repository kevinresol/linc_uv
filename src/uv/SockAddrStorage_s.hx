package uv;

@:semantics(value)
@:include('linc_uv.h')
@:cpp.ValueType({type: 'sockaddr_storage'})
extern class SockAddrStorage_s {
	function new();
}
