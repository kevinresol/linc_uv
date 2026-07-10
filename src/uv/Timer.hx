package uv;

@:dce
abstract Timer(Timer_t) from Timer_t to Timer_t {
	public inline function new()
		this = Alloc.timer();

	public inline function init(loop:Loop)
		return Uv.timer_init(loop, this);

	@:to public inline function asHandle():Handle
		return this;

	public inline function start(cb, timeout, repeat)
		return Uv.timer_start(this, cb, timeout, repeat);

	public inline function stop()
		return Uv.timer_stop(this);
}
