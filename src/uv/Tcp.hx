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

	public inline function connect(req:Connect, dest:SockAddrIn, cb:cpp.Callable<Star<UvConnect>->Int->Void>)
		return Uv.tcp_connect(req, this, dest, cb);

	public inline function bind(addr:SockAddrIn, flags)
		return Uv.tcp_bind(this, addr, flags);

	public inline function nodelay(enable:Bool)
		return Uv.tcp_nodelay(this, enable ? 1 : 0);

	public inline function keepalive(enable:Bool, delay:UInt)
		return Uv.tcp_keepalive(this, enable ? 1 : 0, delay);

	public function getSockAddress():{host:String, port:Int} {
		var host:String = null;
		var port = 0;
		untyped __cpp__('
			sockaddr_storage _name;
			int _namelen = sizeof(_name);
			uv_tcp_getsockname({0}, (sockaddr*)&_name, &_namelen);
			sockaddr_in *_in = (sockaddr_in*)&_name;
			char _addr[64];
			_addr[0] = 0;
			uv_ip4_name(_in, _addr, sizeof(_addr));
			{1} = ::String(_addr);
			{2} = (int)ntohs(_in->sin_port);
		', this, host, port);
		return {host: host, port: port};
	}

	public function getPeerAddress():{host:String, port:Int} {
		var host:String = null;
		var port = 0;
		untyped __cpp__('
			sockaddr_storage _name;
			int _namelen = sizeof(_name);
			uv_tcp_getpeername({0}, (sockaddr*)&_name, &_namelen);
			sockaddr_in *_in = (sockaddr_in*)&_name;
			char _addr[64];
			_addr[0] = 0;
			uv_ip4_name(_in, _addr, sizeof(_addr));
			{1} = ::String(_addr);
			{2} = (int)ntohs(_in->sin_port);
		', this, host, port);
		return {host: host, port: port};
	}
}
