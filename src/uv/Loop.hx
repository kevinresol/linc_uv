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
		Returns the libuv loop attached to `loop`'s `nativeLoop`, creating one if needed.
		Main event loop uses `Loop.DEFAULT`; other loops get a fresh `uv_loop_t`.
	**/
	public static function getFromEventLoop(loop:haxe.EventLoop):Loop {
		if (@:privateAccess loop.nativeLoop == null) {
			if (loop == haxe.EventLoop.main)
				@:privateAccess loop.nativeLoop = new LoopWrapper(DEFAULT);
			else {
				final custom = new Loop();
				final err = custom.init();
				if (err != 0)
					throw 'uv_loop_init failed: $err';
				@:privateAccess loop.nativeLoop = new LoopWrapper(custom);
			}
		}
		final wrapped:LoopWrapper = cast @:privateAccess loop.nativeLoop;
		return wrapped.uvLoop;
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

private class LoopWrapper {
	public final allowsReentrancy = false;
	public final uvLoop:Loop;

	public function new(loop:Loop) {
		this.uvLoop = loop;
	}

	public function run() {
		uvLoop.run(Uv.RUN_NOWAIT);
	}

	public function close() {
		final result = uvLoop.close();
		if (result != 0)
			Sys.println("Some async handlers have not been closed");
	}

	public function isAlive() {
		return uvLoop.alive();
	}
}
