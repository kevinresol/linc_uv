package uv;

import cpp.*;
import uv.Handle.Handle_t;
import uv.Stream.Stream_t;
import uv.Connect.Connect_t;
import uv.Write.Write_t;
import uv.Shutdown.Shutdown_t;
import uv.Timer.Timer_t;

/**
	Plain C struct aliases for libuv callback ABIs.

	PointerType (Handle_t, Stream_t, …) is the marshalling analogue of cpp.Pointer:
	a wrapper, fine when calling into C, but not usable in Callable.fromStaticFunction
	signatures that must match uv_*_cb (raw T*).

	These @:native stubs are the pointee type so Star<UvX> emits T* (same role as
	cpp.Star in the hxcpp pointers cookbook). Native.* rewraps Star → PointerType
	for abstracts. Prefer Star over RawPointer for object callbacks; keep RawPointer
	for C arrays / opaque blobs (e.g. addrinfo*).
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
	public static inline function handle(p:Star<UvHandle>):Handle_t
		return untyped __cpp__('::cpp::marshal::PointerType< ::uv_handle_t >({0})', p);

	public static inline function stream(p:Star<UvStream>):Stream_t
		return untyped __cpp__('::cpp::marshal::PointerType< ::uv_stream_t >({0})', p);

	public static inline function connect(p:Star<UvConnect>):Connect_t
		return untyped __cpp__('::cpp::marshal::PointerType< ::uv_connect_t >({0})', p);

	public static inline function write(p:Star<UvWrite>):Write_t
		return untyped __cpp__('::cpp::marshal::PointerType< ::uv_write_t >({0})', p);

	public static inline function shutdown(p:Star<UvShutdown>):Shutdown_t
		return untyped __cpp__('::cpp::marshal::PointerType< ::uv_shutdown_t >({0})', p);

	public static inline function timer(p:Star<UvTimer>):Timer_t
		return untyped __cpp__('::cpp::marshal::PointerType< ::uv_timer_t >({0})', p);
}
