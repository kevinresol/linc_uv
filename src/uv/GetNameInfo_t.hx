package uv;

@:semantics(value)
@:include('linc_uv.h')
@:cpp.PointerType({type: 'uv_getnameinfo_t'})
extern class GetNameInfo_t extends Req_t {}
