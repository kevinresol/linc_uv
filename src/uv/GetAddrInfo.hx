package uv;

import uv.Req.Req_t;

@:semantics(value)
@:include('linc_uv.h')
@:cpp.PointerType({type: 'uv_getaddrinfo_t'})
extern class GetAddrInfo_t extends Req_t {}

@:dce
abstract GetAddrInfo(GetAddrInfo_t) from GetAddrInfo_t to GetAddrInfo_t {
	public inline function new()
		this = Alloc.getAddrInfo();

	public inline function get(loop:Loop, cb, host, port, hints:AddrInfo)
		return Uv.getaddrinfo(loop, this, cb, host, port, hints);
}
