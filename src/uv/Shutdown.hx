package uv;

@:dce
abstract Shutdown(Shutdown_t) from Shutdown_t to Shutdown_t {
	public var handle(get, never):Stream;

	inline function get_handle():Stream
		return untyped __cpp__('::cpp::marshal::PointerType< ::uv_stream_t >(({0})->handle)', this);

	public inline function new()
		this = Alloc.shutdown();

	public inline function setData<T>(v:Data<T>)
		this.data = cast v;

	public inline function getData<T>():Data<T>
		return cast this.data;

	@:to public inline function asReq():Req
		return this;
}
