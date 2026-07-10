package uv;

@:include('linc_uv.h')
@:native('uv_run_mode')
@:scalar @:coreType @:notNull
extern abstract RunMode from(Int) to(Int) {}
