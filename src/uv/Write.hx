package uv;

import uv.Req.Req_t;
import uv.Stream.Stream_t;

@:semantics(value)
@:include('linc_uv.h')
@:cpp.PointerType({type: 'uv_write_t'})
extern class Write_t extends Req_t {
	var handle:Stream_t;
}

@:dce
abstract Write(Write_t) from Write_t to Write_t {
	public var handle(get, never):Stream;

	inline function get_handle():Stream
		return untyped __cpp__('::cpp::marshal::PointerType< ::uv_stream_t >(({0})->handle)', this);

	public inline function new()
		this = Alloc.write();

	public inline function setData<T>(v:Data<T>)
		this.data = cast v;

	public inline function getData<T>():Data<T>
		return cast this.data;

	@:to public inline function asReq():Req
		return this;
}
