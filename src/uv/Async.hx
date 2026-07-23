package uv;

import cpp.Callable;
import cpp.Star;
import uv.Handle.Handle_t;
import uv.Native.UvAsync;

@:semantics(value)
@:include('linc_uv.h')
@:cpp.PointerType({type: 'uv_async_t'})
extern class Async_t extends Handle_t {}

@:dce
abstract Async(Async_t) from Async_t to Async_t {
	public inline function new()
		this = Alloc.async();

	public inline function init(loop:Loop, cb:Callable<Star<UvAsync>->Void>)
		return Uv.async_init(loop, this, cb);

	@:to public inline function asHandle():Handle
		return this;

	public inline function send()
		return Uv.async_send(this);
}
