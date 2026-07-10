package uv;

@:dce
abstract GetAddrInfo(GetAddrInfo_t) from GetAddrInfo_t to GetAddrInfo_t {
	public inline function new()
		this = Alloc.getAddrInfo();

	public inline function get(loop:Loop, cb, host, port, hints:AddrInfo)
		return Uv.getaddrinfo(loop, this, cb, host, port, hints);
}
