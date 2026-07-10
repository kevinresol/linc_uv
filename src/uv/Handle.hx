package uv;

import cpp.Star;
import uv.Native.UvHandle;

@:semantics(value)
@:include('linc_uv.h')
@:cpp.PointerType({type: 'uv_handle_t'})
extern class Handle_t {
	var data:Star<cpp.Void>;
}

@:dce
abstract Handle(Handle_t) from Handle_t to Handle_t {
	public inline function setData<T>(v:Data<T>)
		this.data = cast v;

	public inline function getData<T>():Data<T>
		return cast this.data;

	public inline function close(cb:cpp.Callable<cpp.RawPointer<UvHandle>->Void>)
		Uv.close(this, cb);

	public inline function isClosing()
		return Uv.is_closing(this) != 0;

	public inline function isActive()
		return Uv.is_active(this) != 0;

	public inline function ref()
		Uv.ref(this);

	public inline function unref()
		Uv.unref(this);

	public inline function hasRef()
		return Uv.has_ref(this) != 0;
}
