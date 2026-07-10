package uv;

@:semantics(value)
@:include('linc_uv.h')
@:cpp.PointerType({type: 'uv_fs_t'})
extern class Fs_t extends Req_t {
	var result:SSizeT;
}
