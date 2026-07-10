package uv;

import cpp.*;
import uv.Stream.Stream_t;
import uv.Native.UvConnect;

@:semantics(value)
@:include('linc_uv.h')
@:cpp.PointerType({type: 'uv_tcp_t'})
extern class Tcp_t extends Stream_t {}

@:dce
abstract Tcp(Tcp_t) from Tcp_t to Tcp_t {
	public inline function new()
		this = Alloc.tcp();

	public inline function init(loop:Loop)
		return Uv.tcp_init(loop, this);

	@:to public inline function asStream():Stream
		return this;

	@:to public inline function asHandle():Handle
		return this;

	public inline function setData<T>(v:Data<T>)
		this.data = cast v;

	public inline function getData<T>():Data<T>
		return cast this.data;

	public inline function connect(req:Connect, dest:SockAddrIn, cb:cpp.Callable<RawPointer<UvConnect>->Int->Void>)
		return Uv.tcp_connect(req, this, dest, cb);

	public inline function bind(addr:SockAddrIn, flags)
		return Uv.tcp_bind(this, addr, flags);

	public inline function nodelay(enable:Bool)
		return Uv.tcp_nodelay(this, enable ? 1 : 0);

	public inline function keepalive(enable:Bool, delay:UInt)
		return Uv.tcp_keepalive(this, enable ? 1 : 0, delay);

	public function getSockAddress() {
		var name = new SockAddrStorage();
		var namelen = name.sizeof();
		Uv.tcp_getsockname(this, name, Pointer.addressOf(namelen).ptr);
		return name.asSockAddrIn().getAddress();
	}

	public function getPeerAddress() {
		var name = new SockAddrStorage();
		var namelen = name.sizeof();
		Uv.tcp_getpeername(this, name, Pointer.addressOf(namelen).ptr);
		return name.asSockAddrIn().getAddress();
	}
}
