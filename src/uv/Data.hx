package uv;

#if !macro
import cpp.*;

abstract Data<T>(Star<cpp.Void>) {
	@:from public inline static function fromAny<T>(v:T):Data<T>
		return untyped __cpp__('{0}.GetPtr()', v);

	@:to public inline function toAny():T
		return untyped __cpp__('(hx::Object*){0}', this);
}
#else
class Data {
	public static function inject() {
		return haxe.macro.Context.getBuildFields();
	}
}
#end
