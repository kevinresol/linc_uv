package uv;

@:semantics(value)
@:include('linc_uv.h')
@:cpp.PointerType({type: 'uv_getaddrinfo_t'})
extern class GetAddrInfo_t extends Req_t {}
