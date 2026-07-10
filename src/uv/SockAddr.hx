package uv;

@:semantics(value)
@:include('linc_uv.h')
@:cpp.ValueType({type: 'sockaddr'})
extern class SockAddr_s {
	function new();
}

@:dce
abstract SockAddr(SockAddr_s) from SockAddr_s to SockAddr_s {
	public inline function new()
		this = new SockAddr_s();
}
