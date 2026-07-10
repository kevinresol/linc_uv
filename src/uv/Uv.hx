package uv;

import cpp.*;

import uv.Native.UvHandle;
import uv.Native.UvStream;
import uv.Native.UvConnect;
import uv.Native.UvWrite;
import uv.Native.UvShutdown;
import uv.Native.UvTimer;
import uv.Native.UvFs;
import uv.Native.UvGetAddrInfo;
import uv.Native.UvGetNameInfo;

@:keep
@:include('linc_uv.h')
@:build(linc.Linc.touch())
@:build(linc.Linc.xml('uv', '../../'))
extern class Uv {
	// error
	@:native("UV_E2BIG") public static var E2BIG:Int;
	@:native("UV_EACCES") public static var EACCES:Int;
	@:native("UV_EADDRINUSE") public static var EADDRINUSE:Int;
	@:native("UV_EADDRNOTAVAIL") public static var EADDRNOTAVAIL:Int;
	@:native("UV_EAFNOSUPPORT") public static var EAFNOSUPPORT:Int;
	@:native("UV_EAGAIN") public static var EAGAIN:Int;
	@:native("UV_EAI_ADDRFAMILY") public static var EAI_ADDRFAMILY:Int;
	@:native("UV_EAI_AGAIN") public static var EAI_AGAIN:Int;
	@:native("UV_EAI_BADFLAGS") public static var EAI_BADFLAGS:Int;
	@:native("UV_EAI_BADHINTS") public static var EAI_BADHINTS:Int;
	@:native("UV_EAI_CANCELED") public static var EAI_CANCELED:Int;
	@:native("UV_EAI_FAIL") public static var EAI_FAIL:Int;
	@:native("UV_EAI_FAMILY") public static var EAI_FAMILY:Int;
	@:native("UV_EAI_MEMORY") public static var EAI_MEMORY:Int;
	@:native("UV_EAI_NODATA") public static var EAI_NODATA:Int;
	@:native("UV_EAI_NONAME") public static var EAI_NONAME:Int;
	@:native("UV_EAI_OVERFLOW") public static var EAI_OVERFLOW:Int;
	@:native("UV_EAI_PROTOCOL") public static var EAI_PROTOCOL:Int;
	@:native("UV_EAI_SERVICE") public static var EAI_SERVICE:Int;
	@:native("UV_EAI_SOCKTYPE") public static var EAI_SOCKTYPE:Int;
	@:native("UV_EALREADY") public static var EALREADY:Int;
	@:native("UV_EBADF") public static var EBADF:Int;
	@:native("UV_EBUSY") public static var EBUSY:Int;
	@:native("UV_ECANCELED") public static var ECANCELED:Int;
	@:native("UV_ECHARSET") public static var ECHARSET:Int;
	@:native("UV_ECONNABORTED") public static var ECONNABORTED:Int;
	@:native("UV_ECONNREFUSED") public static var ECONNREFUSED:Int;
	@:native("UV_ECONNRESET") public static var ECONNRESET:Int;
	@:native("UV_EDESTADDRREQ") public static var EDESTADDRREQ:Int;
	@:native("UV_EEXIST") public static var EEXIST:Int;
	@:native("UV_EFAULT") public static var EFAULT:Int;
	@:native("UV_EFBIG") public static var EFBIG:Int;
	@:native("UV_EHOSTUNREACH") public static var EHOSTUNREACH:Int;
	@:native("UV_EINTR") public static var EINTR:Int;
	@:native("UV_EINVAL") public static var EINVAL:Int;
	@:native("UV_EIO") public static var EIO:Int;
	@:native("UV_EISCONN") public static var EISCONN:Int;
	@:native("UV_EISDIR") public static var EISDIR:Int;
	@:native("UV_ELOOP") public static var ELOOP:Int;
	@:native("UV_EMFILE") public static var EMFILE:Int;
	@:native("UV_EMSGSIZE") public static var EMSGSIZE:Int;
	@:native("UV_ENAMETOOLONG") public static var ENAMETOOLONG:Int;
	@:native("UV_ENETDOWN") public static var ENETDOWN:Int;
	@:native("UV_ENETUNREACH") public static var ENETUNREACH:Int;
	@:native("UV_ENFILE") public static var ENFILE:Int;
	@:native("UV_ENOBUFS") public static var ENOBUFS:Int;
	@:native("UV_ENODEV") public static var ENODEV:Int;
	@:native("UV_ENOENT") public static var ENOENT:Int;
	@:native("UV_ENOMEM") public static var ENOMEM:Int;
	@:native("UV_ENONET") public static var ENONET:Int;
	@:native("UV_ENOPROTOOPT") public static var ENOPROTOOPT:Int;
	@:native("UV_ENOSPC") public static var ENOSPC:Int;
	@:native("UV_ENOSYS") public static var ENOSYS:Int;
	@:native("UV_ENOTCONN") public static var ENOTCONN:Int;
	@:native("UV_ENOTDIR") public static var ENOTDIR:Int;
	@:native("UV_ENOTEMPTY") public static var ENOTEMPTY:Int;
	@:native("UV_ENOTSOCK") public static var ENOTSOCK:Int;
	@:native("UV_ENOTSUP") public static var ENOTSUP:Int;
	@:native("UV_EPERM") public static var EPERM:Int;
	@:native("UV_EPIPE") public static var EPIPE:Int;
	@:native("UV_EPROTO") public static var EPROTO:Int;
	@:native("UV_EPROTONOSUPPORT") public static var EPROTONOSUPPORT:Int;
	@:native("UV_EPROTOTYPE") public static var EPROTOTYPE:Int;
	@:native("UV_ERANGE") public static var ERANGE:Int;
	@:native("UV_EROFS") public static var EROFS:Int;
	@:native("UV_ESHUTDOWN") public static var ESHUTDOWN:Int;
	@:native("UV_ESPIPE") public static var ESPIPE:Int;
	@:native("UV_ESRCH") public static var ESRCH:Int;
	@:native("UV_ETIMEDOUT") public static var ETIMEDOUT:Int;
	@:native("UV_ETXTBSY") public static var ETXTBSY:Int;
	@:native("UV_EXDEV") public static var EXDEV:Int;
	@:native("UV_UNKNOWN") public static var UNKNOWN:Int;
	@:native("UV_EOF") public static var EOF:Int;
	@:native("UV_ENXIO") public static var ENXIO:Int;
	@:native("UV_EMLINK") public static var EMLINK:Int;

	// fs open mode
	@:native("UV_FS_O_APPEND") public static var FS_O_APPEND:Int;
	@:native("UV_FS_O_CREAT") public static var FS_O_CREAT:Int;
	@:native("UV_FS_O_DIRECT") public static var FS_O_DIRECT:Int;
	@:native("UV_FS_O_DIRECTORY") public static var FS_O_DIRECTORY:Int;
	@:native("UV_FS_O_DSYNC") public static var FS_O_DSYNC:Int;
	@:native("UV_FS_O_EXCL") public static var FS_O_EXCL:Int;
	@:native("UV_FS_O_EXLOCK") public static var FS_O_EXLOCK:Int;
	@:native("UV_FS_O_NOATIME") public static var FS_O_NOATIME:Int;
	@:native("UV_FS_O_NOCTTY") public static var FS_O_NOCTTY:Int;
	@:native("UV_FS_O_NOFOLLOW") public static var FS_O_NOFOLLOW:Int;
	@:native("UV_FS_O_NONBLOCK") public static var FS_O_NONBLOCK:Int;
	@:native("UV_FS_O_RDONLY") public static var FS_O_RDONLY:Int;
	@:native("UV_FS_O_RDWR") public static var FS_O_RDWR:Int;
	@:native("UV_FS_O_SYMLINK") public static var FS_O_SYMLINK:Int;
	@:native("UV_FS_O_SYNC") public static var FS_O_SYNC:Int;
	@:native("UV_FS_O_TRUNC") public static var FS_O_TRUNC:Int;
	@:native("UV_FS_O_WRONLY") public static var FS_O_WRONLY:Int;
	@:native("UV_FS_O_RANDOM") public static var FS_O_RANDOM:Int;
	@:native("UV_FS_O_SHORT_LIVED") public static var FS_O_SHORT_LIVED:Int;
	@:native("UV_FS_O_SEQUENTIAL") public static var FS_O_SEQUENTIAL:Int;
	@:native("UV_FS_O_TEMPORARY") public static var FS_O_TEMPORARY:Int;

	// uv_run_mode
	@:native("UV_RUN_DEFAULT") public static var RUN_DEFAULT:RunMode;
	@:native("UV_RUN_ONCE") public static var RUN_ONCE:RunMode;
	@:native("UV_RUN_NOWAIT") public static var RUN_NOWAIT:RunMode;

	// misc
	@:native("AF_INET") public static var AF_INET:Int;
	@:native("AF_INET6") public static var AF_INET6:Int;
	@:native("UV_TCP") public static var TCP:HandleType;
	@:native("UV_NAMED_PIPE") public static var NAMED_PIPE:HandleType;
	@:native("UV_TTY") public static var TTY:HandleType;
	@:native("UV_TIMER") public static var TIMER:HandleType;
	@:native("UV_CONNECT") public static var CONNECT:ReqType;
	@:native("UV_WRITE") public static var WRITE:ReqType;
	@:native("UV_SHUTDOWN") public static var SHUTDOWN:ReqType;
	@:native("UV_FS") public static var FS:ReqType;
	@:native("UV_GETADDRINFO") public static var GETADDRINFO:ReqType;

	// error
	@:native("uv_strerror") public static function strerror(code:Int):ConstCharStar;
	@:native("uv_err_name") public static function err_name(code:Int):ConstCharStar;

	// loop
	@:native("uv_default_loop") public static function default_loop():Loop_t;
	@:native("uv_loop_init") public static function loop_init(loop:Loop_t):Int;
	@:native("uv_loop_close") public static function loop_close(loop:Loop_t):Int;
	@:native("uv_loop_alive") public static function loop_alive(loop:Loop_t):Int;
	@:native("uv_run") public static function run(loop:Loop_t, mode:RunMode):Int;
	@:native("uv_stop") public static function stop(loop:Loop_t):Void;

	// timer
	@:native("uv_timer_init") public static function timer_init(loop:Loop_t, timer:Timer_t):Int;
	@:native("uv_timer_start") public static function timer_start(timer:Timer_t, cb:Callable<RawPointer<UvTimer>->Void>, timeout:UInt64, repeat:UInt64):Int;
	@:native("uv_timer_stop") public static function timer_stop(timer:Timer_t):Int;

	// tcp
	@:native("uv_tcp_init") public static function tcp_init(loop:Loop_t, handle:Tcp_t):Int;
	@:native("linc::uv::tcp_bind") public static function tcp_bind(handle:Tcp_t, addr:SockAddrIn_s, flags:Int):Int;
	@:native("linc::uv::tcp_connect") public static function tcp_connect(req:Connect_t, handle:Tcp_t, addr:SockAddrIn_s, cb:Callable<RawPointer<UvConnect>->Int->Void>):Int;
	@:native("uv_tcp_getsockname") public static function tcp_getsockname(handle:Tcp_t, name:SockAddrStorage_s, namelen:Star<Int>):Int;
	@:native("uv_tcp_getpeername") public static function tcp_getpeername(handle:Tcp_t, name:SockAddrStorage_s, namelen:Star<Int>):Int;
	@:native("uv_tcp_nodelay") public static function tcp_nodelay(handle:Tcp_t, enable:Int):Int;
	@:native("uv_tcp_keepalive") public static function tcp_keepalive(handle:Tcp_t, enable:Int, delay:UInt):Int;

	// stream
	@:native("uv_shutdown") public static function shutdown(req:Shutdown_t, handle:Stream_t, cb:Callable<RawPointer<UvShutdown>->Int->Void>):Int;
	@:native("uv_listen") public static function listen(handle:Stream_t, backlog:Int, cb:Callable<RawPointer<UvStream>->Int->Void>):Int;
	@:native("uv_accept") public static function accept(server:Stream_t, client:Stream_t):Int;
	@:native("uv_read_start") public static function read_start(handle:Stream_t, alloc_cb:Callable<RawPointer<UvHandle>->SizeT->Star<Buf_t>->Void>,
		read_cb:Callable<RawPointer<UvStream>->SSizeT->ConstStar<Buf_t>->Void>):Int;
	@:native("uv_read_stop") public static function read_stop(handle:Stream_t):Int;
	@:native("uv_write") public static function write(req:Write_t, handle:Stream_t, bufs:Buf_t, nbufs:UInt32, cb:Callable<RawPointer<UvWrite>->Int->Void>):Int;
	@:native("uv_try_write") public static function try_write(handle:Stream_t, bufs:Buf_t, nbufs:UInt32):Int;
	@:native("uv_is_readable") public static function is_readable(handle:Stream_t):Int;
	@:native("uv_is_writable") public static function is_writable(handle:Stream_t):Int;

	// handle
	@:native("uv_is_active") public static function is_active(handle:Handle_t):Int;
	@:native("uv_is_closing") public static function is_closing(handle:Handle_t):Int;
	@:native("uv_close") public static function close(handle:Handle_t, close_cb:Callable<RawPointer<UvHandle>->Void>):Void;
	@:native("uv_ref") public static function ref(handle:Handle_t):Void;
	@:native("uv_unref") public static function unref(handle:Handle_t):Void;
	@:native("uv_has_ref") public static function has_ref(handle:Handle_t):Int;
	@:native("uv_handle_size") public static function handle_size(type:HandleType):SizeT;
	@:native("uv_req_size") public static function req_size(type:ReqType):SizeT;

	// fs
	@:native("uv_fs_open") public static function fs_open(loop:Loop_t, req:Fs_t, path:ConstCharStar, flags:Int, mode:Int, cb:Callable<RawPointer<UvFs>->Void>):Int;
	@:native("uv_fs_close") public static function fs_close(loop:Loop_t, req:Fs_t, file:File, cb:Callable<RawPointer<UvFs>->Void>):Int;
	@:native("uv_fs_read") public static function fs_read(loop:Loop_t, req:Fs_t, file:File, bufs:Buf_t, nbufs:UInt32, offset:UInt64, cb:Callable<RawPointer<UvFs>->Void>):Int;
	@:native("uv_fs_unlink") public static function fs_unlink(loop:Loop_t, req:Fs_t, path:ConstCharStar, cb:Callable<RawPointer<UvFs>->Void>):Int;
	@:native("uv_fs_write") public static function fs_write(loop:Loop_t, req:Fs_t, file:File, bufs:Buf_t, nbufs:UInt32, offset:UInt64, cb:Callable<RawPointer<UvFs>->Void>):Int;

	// pipe
	@:native("uv_pipe_init") public static function pipe_init(loop:Loop_t, handle:Pipe_t, ipc:Int):Int;
	@:native("uv_pipe_open") public static function pipe_open(handle:Pipe_t, file:File):Int;

	// dns
	@:native("uv_getaddrinfo") public static function getaddrinfo(loop:Loop_t, req:GetAddrInfo_t, getaddrinfo_cb:Callable<RawPointer<UvGetAddrInfo>->Int->RawPointer<cpp.Void>->Void>,
		node:ConstCharStar, service:ConstCharStar, hints:AddrInfo_s):Int;
	@:native("uv_freeaddrinfo") public static function freeaddrinfo(ai:RawPointer<cpp.Void>):Void;
	@:native("uv_getnameinfo") public static function getnameinfo(loop:Loop_t, req:GetNameInfo_t, getnameinfo_cb:Callable<RawPointer<UvGetNameInfo>->Int->ConstCharStar->ConstCharStar->Void>,
		addr:SockAddr_s, flags:Int):Int;

	// misc
	@:native("uv_buf_init") public static function buf_init(base:Star<Char>, len:UInt32):Buf_t;
	@:native("uv_ip4_addr") public static function ip4_addr(ip:ConstCharStar, port:Int, addr:SockAddrIn_s):Int;
	@:native("uv_ip4_name") public static function ip4_name(src:SockAddrIn_s, dst:Star<Char>, size:SizeT):Int;
	@:native("uv_hrtime") public static function hrtime():UInt64;
	@:native("uv_inet_ntop") public static function inet_ntop(af:Int, src:ConstStar<cpp.Void>, dst:Star<Char>, size:SizeT):Int;
	@:native("uv_inet_pton") public static function inet_pton(af:Int, src:ConstCharStar, dst:Star<cpp.Void>):Int;
}


