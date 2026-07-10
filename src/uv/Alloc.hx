package uv;

/**
	Malloc/free for libuv PointerType handles and requests.
	PointerTypes have no constructors; callers own the memory until after close/completion.
**/
@:include('linc_uv.h')
extern class Alloc {
	@:native('linc::uv::alloc_loop')
	public static function loop():Loop_t;

	@:native('linc::uv::alloc_tcp')
	public static function tcp():Tcp_t;

	@:native('linc::uv::alloc_pipe')
	public static function pipe():Pipe_t;

	@:native('linc::uv::alloc_timer')
	public static function timer():Timer_t;

	@:native('linc::uv::alloc_connect')
	public static function connect():Connect_t;

	@:native('linc::uv::alloc_write')
	public static function write():Write_t;

	@:native('linc::uv::alloc_shutdown')
	public static function shutdown():Shutdown_t;

	@:native('linc::uv::alloc_fs')
	public static function fs():Fs_t;

	@:native('linc::uv::alloc_getaddrinfo')
	public static function getAddrInfo():GetAddrInfo_t;

	@:native('linc::uv::free_ptr')
	public static function free(p:cpp.RawPointer<cpp.Void>):Void;
}
