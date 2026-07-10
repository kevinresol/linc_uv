package uv;

@:semantics(value)
@:include('linc_uv.h')
@:cpp.ValueType({type: 'sockaddr_in'})
extern class SockAddrIn_s {
	function new();
}

@:dce
abstract SockAddrIn(SockAddrIn_s) from SockAddrIn_s to SockAddrIn_s {
	public inline function new()
		this = new SockAddrIn_s();

	public inline function asSockAddr():SockAddr
		return untyped __cpp__('*(::sockaddr*)&{0}', this);

	public inline function ip4Addr(host:String, port:Int)
		return Uv.ip4_addr(host, port, this);

	public function getAddress():{host:String, port:Int} {
		untyped __cpp__('char addr[17] = {\'\\0\'}');
		Uv.ip4_name(this, untyped __cpp__('addr'), cast 16);
		return {
			host: untyped __cpp__('::String(addr)'),
			port: untyped __cpp__('ntohs({0}.sin_port)', this),
		}
	}
}
