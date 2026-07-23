package uv;

import cpp.Star;

@:semantics(value)
@:include('linc_uv.h')
@:cpp.PointerType({type: 'uv_loop_t'})
extern class Loop_t {
	var data:Star<cpp.Void>;
}

@:dce
abstract Loop(Loop_t) from Loop_t to Loop_t {
	public static var DEFAULT(get, never):Loop;

	static inline function get_DEFAULT():Loop
		return Uv.default_loop();

	/**
		Attach a libuv loop to `loop` as its waiting driver and return the UV
		`Loop` **synchronously**.

		Install uses `swapDriver`: when called from an event callback (`inLoop`)
		or another thread, apply is deferred until the next `applyPendingSwap`.
		A pending UV swap counts as external work so `loop()` cannot idle-exit
		before the driver is published. Idempotent: if a UV driver is already
		current or pending for this EventLoop, its loop is reused.

		Main event loop uses `Loop.DEFAULT` with `isDefault=true`; other loops
		get a fresh `uv_loop_t` with `isDefault=false`.
	**/
	public static function getFromEventLoop(loop:haxe.EventLoop):Loop {
		final current = loop.getDriver();
		if (Std.isOfType(current, UvEventLoopDriver))
			return (cast current : UvEventLoopDriver).uvLoop;
		final pending = loop.getPendingDriver();
		if (pending != null && Std.isOfType(pending, UvEventLoopDriver))
			return (cast pending : UvEventLoopDriver).uvLoop;

		final isDefault = loop == haxe.EventLoop.main;
		final uvLoop = if (isDefault) {
			DEFAULT;
		} else {
			final custom = new Loop();
			final err = custom.init();
			if (err != 0)
				throw 'uv_loop_init failed: $err';
			custom;
		};
		final driver = new UvEventLoopDriver(uvLoop, isDefault);
		loop.swapDriver(driver);
		return uvLoop;
	}

	public inline function new()
		this = Alloc.loop();

	public inline function init()
		return Uv.loop_init(this);

	public inline function setData<T>(v:Data<T>)
		this.data = cast v;

	public inline function getData<T>():Data<T>
		return cast this.data;

	public inline function run(mode)
		return Uv.run(this, mode);

	public inline function stop()
		Uv.stop(this);

	public inline function close()
		return Uv.loop_close(this);

	public inline function alive()
		return Uv.loop_alive(this) != 0;

	public inline function open(req:Fs, path, flags, mode, cb)
		return Uv.fs_open(this, req, path, flags, mode, cb);

	public inline function closeFs(req:Fs, file, cb)
		return Uv.fs_close(this, req, file, cb);

	public inline function read(req:Fs, file, bufs, nbufs, offset, cb)
		return Uv.fs_read(this, req, file, bufs, nbufs, offset, cb);

	public inline function unlink(req:Fs, path, cb)
		return Uv.fs_unlink(this, req, path, cb);

	public inline function write(req:Fs, file, bufs, nbufs, offset, cb)
		return Uv.fs_write(this, req, file, bufs, nbufs, offset, cb);
}
