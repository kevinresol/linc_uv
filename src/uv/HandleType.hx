package uv;

@:include('linc_uv.h')
@:native('uv_handle_type')
@:scalar @:coreType @:notNull
extern abstract HandleType from(Int) to(Int) {}
