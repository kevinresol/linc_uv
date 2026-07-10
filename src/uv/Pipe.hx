package uv;

@:dce
abstract Pipe(Pipe_t) from Pipe_t to Pipe_t {
	public inline function new()
		this = Alloc.pipe();

	public inline function init(loop:Loop, ipc)
		return Uv.pipe_init(loop, this, ipc);

	@:to public inline function asStream():Stream
		return this;

	@:to public inline function asHandle():Handle
		return this;

	public inline function open(file)
		return Uv.pipe_open(this, file);
}
