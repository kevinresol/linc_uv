package uv;

@:include('linc_uv.h')
@:native('uv_req_type')
@:scalar @:coreType @:notNull
extern abstract ReqType from(Int) to(Int) {}
