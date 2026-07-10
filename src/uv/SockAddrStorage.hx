package uv;

import cpp.Stdlib;

@:semantics(value)
@:include('linc_uv.h')
@:cpp.ValueType({type: 'sockaddr_storage'})
extern class SockAddrStorage_s {
	function new();
}

@:dce
abstract SockAddrStorage(SockAddrStorage_s) from SockAddrStorage_s to SockAddrStorage_s {
	public inline function new()
		this = new SockAddrStorage_s();

	public inline function asSockAddr():SockAddr
		return untyped __cpp__('*(::sockaddr*)&{0}', this);

	public inline function asSockAddrIn():SockAddrIn
		return untyped __cpp__('*(::sockaddr_in*)&{0}', this);

	public inline function sizeof()
		return Stdlib.sizeof(SockAddrStorage_s);
}
