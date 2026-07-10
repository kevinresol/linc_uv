package uv;

@:dce
abstract SockAddr(SockAddr_s) from SockAddr_s to SockAddr_s {
	public inline function new()
		this = new SockAddr_s();
}
