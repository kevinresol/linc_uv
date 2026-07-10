package uv;

@:semantics(value)
@:include('linc_uv.h')
@:cpp.ValueType({type: 'addrinfo'})
extern class AddrInfo_s {
	var ai_flags:Int;
	var ai_family:Int;
	var ai_socktype:Int;
	var ai_protocol:Int;
	function new();
}

@:dce
abstract AddrInfo(AddrInfo_s) from AddrInfo_s to AddrInfo_s {
	public inline function new() {
		this = new AddrInfo_s();
		untyped __cpp__('{0}.ai_family = PF_INET;{0}.ai_socktype = SOCK_STREAM;{0}.ai_protocol = IPPROTO_TCP;{0}.ai_flags = 0;', this);
	}
}
