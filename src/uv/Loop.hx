package uv;

@:dce
abstract Loop(Loop_t) from Loop_t to Loop_t {
	public static var DEFAULT(get, never):Loop;

	static inline function get_DEFAULT():Loop
		return Uv.default_loop();

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
