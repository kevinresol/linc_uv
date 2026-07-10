package uv;

@:include('linc_uv.h')
@:native("uv_file")
@:scalar @:coreType @:notNull
extern abstract File from(Int) to(Int) {}
