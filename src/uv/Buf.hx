package uv;

import cpp.*;

@:semantics(value)
@:include('linc_uv.h')
@:cpp.ValueType({type: 'uv_buf_t'})
extern class Buf_t {
	var base:CastCharStar;
	var len:SizeT;
	function new();
}

@:dce
abstract Buf(Buf_t) from Buf_t to Buf_t {
	public var base(get, set):CastCharStar;
	public var len(get, set):SizeT;

	inline function get_base()
		return this.base;

	inline function set_base(v)
		return this.base = v;

	inline function get_len()
		return this.len;

	inline function set_len(v)
		return this.len = v;

	public inline function new()
		this = new Buf_t();

	public inline function alloc(size:Int) {
		this.base = untyped __cpp__('(char*){0}', Stdlib.nativeMalloc(size));
		this.len = cast size;
	}

	public inline function freeBase()
		Stdlib.nativeFree(cast this.base);

	public inline function copyFromAddress(src:CastCharStar, size:Int)
		Stdlib.nativeMemcpy(cast this.base, cast src, size);

	public inline function copyFrom(src:ConstStar<Buf_t>, size:Int)
		copyFromAddress(src.base, size);

	public inline function copyFromBytes(bytes:haxe.io.Bytes, size:Int) {
		untyped __cpp__('memcpy({0}, (char*){1}->GetBase(), {2})', this.base, bytes.getData(), size);
	}

	public inline function copyToBytes(bytes:haxe.io.Bytes, size:Int) {
		untyped __cpp__('memcpy((char*){0}->GetBase(), {1}, {2})', bytes.getData(), this.base, size);
	}

	public static inline function unmanaged(b:ConstStar<Buf_t>):UnmanagedBuf
		return b;
}
