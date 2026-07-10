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
