package uv;

@:dce
abstract UnmanagedBuf(cpp.ConstStar<Buf_t>) from cpp.ConstStar<Buf_t> to cpp.ConstStar<Buf_t> {
	public inline function free()
		cpp.Stdlib.nativeFree(cast this.base);

	public inline function copyToBytes(bytes:haxe.io.Bytes, size:Int) {
		untyped __cpp__('memcpy((char*){0}->GetBase(), {1}, {2})', bytes.getData(), this.base, size);
	}
}
