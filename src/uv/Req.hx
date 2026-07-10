package uv;

@:dce
abstract Req(Req_t) from Req_t to Req_t {
	public inline function setData<T>(v:Data<T>)
		this.data = cast v;

	public inline function getData<T>():Data<T>
		return cast this.data;
}
