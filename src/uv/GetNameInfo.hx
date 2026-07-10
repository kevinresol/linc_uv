package uv;

import uv.Req.Req_t;

@:semantics(value)
@:include('linc_uv.h')
@:cpp.PointerType({type: 'uv_getnameinfo_t'})
extern class GetNameInfo_t extends Req_t {}

@:dce
abstract GetNameInfo(GetNameInfo_t) from GetNameInfo_t to GetNameInfo_t {}
