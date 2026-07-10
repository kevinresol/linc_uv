package uv;

import cpp.*;

/**
	Plain C struct aliases for libuv callback ABIs.
	PointerType params become PointerType wrappers in fromStaticFunction,
	which are not convertible to uv_*_cb (raw T*). Use these with RawPointer.
**/
@:native('uv_handle_t')
extern class UvHandle {}

@:native('uv_stream_t')
extern class UvStream {}

@:native('uv_connect_t')
extern class UvConnect {}

@:native('uv_write_t')
extern class UvWrite {}

@:native('uv_shutdown_t')
extern class UvShutdown {}

@:native('uv_timer_t')
extern class UvTimer {}

@:native('uv_fs_t')
extern class UvFs {}

@:native('uv_getaddrinfo_t')
extern class UvGetAddrInfo {}

@:native('uv_getnameinfo_t')
extern class UvGetNameInfo {}

class Native {
	public static inline function handle(p:RawPointer<UvHandle>):Handle_t
		return untyped __cpp__('::cpp::marshal::PointerType< ::uv_handle_t >({0})', p);

	public static inline function stream(p:RawPointer<UvStream>):Stream_t
		return untyped __cpp__('::cpp::marshal::PointerType< ::uv_stream_t >({0})', p);

	public static inline function connect(p:RawPointer<UvConnect>):Connect_t
		return untyped __cpp__('::cpp::marshal::PointerType< ::uv_connect_t >({0})', p);

	public static inline function write(p:RawPointer<UvWrite>):Write_t
		return untyped __cpp__('::cpp::marshal::PointerType< ::uv_write_t >({0})', p);

	public static inline function shutdown(p:RawPointer<UvShutdown>):Shutdown_t
		return untyped __cpp__('::cpp::marshal::PointerType< ::uv_shutdown_t >({0})', p);
}
