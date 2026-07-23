package uv;

import cpp.Callable;
import cpp.Star;
import uv.Native.UvAsync;
import uv.Native.UvHandle;
import uv.Native.UvTimer;

/**
	LibUV-backed `haxe.EventLoopDriver`.

	Owns an async doorbell and a one-shot deadline timer on `uvLoop`. While
	`wait(maxBlock)` blocks (`maxBlock >= 0`), the async handle is referenced so
	`UV_RUN_ONCE` does not busy-spin when only driver handles exist. Outside
	waits both handles stay unreferenced so they alone do not keep the loop
	alive (`hasExternalWork`).

	`isDefault` must be `true` for the process-global default loop: `close`
	then only closes driver-owned handles and never calls `uv_loop_close`.
**/
class UvEventLoopDriver implements haxe.EventLoopDriver {
	public final allowsReentrancy = false;

	/** Underlying libuv loop (for `getFromEventLoop` idempotent reuse). **/
	public final uvLoop:Loop;

	final isDefault:Bool;
	/**
		Haxe-reachable Callables for libuv callbacks (hxcpp GC).
		Mirrors HL `keepAliveCb`: keep the Callable instances alive for the
		lifetime of the driver so GC cannot collect them while native code
		still holds the function pointer.
	**/
	final keepAliveAsync:Callable<Star<UvAsync>->Void>;
	final keepAliveTimer:Callable<Star<UvTimer>->Void>;
	final keepAliveClose:Callable<Star<UvHandle>->Void>;

	var asyncHandle:Null<Async>;
	var timerHandle:Null<Timer>;
	var closed = false;

	/**
		@param uvLoop libuv loop to drive
		@param isDefault `true` when `uvLoop` is the process default loop
	**/
	public function new(uvLoop:Loop, isDefault:Bool) {
		this.uvLoop = uvLoop;
		this.isDefault = isDefault;
		keepAliveAsync = Callable.fromStaticFunction(noopAsync);
		keepAliveTimer = Callable.fromStaticFunction(noopTimer);
		keepAliveClose = Callable.fromStaticFunction(noopClose);

		final async = new Async();
		final asyncErr = async.init(uvLoop, keepAliveAsync);
		if (asyncErr != 0)
			throw 'Failed to create uv_async_t wake handle: $asyncErr';
		asyncHandle = async;
		async.asHandle().unref();

		final timer = new Timer();
		final timerErr = timer.init(uvLoop);
		if (timerErr != 0) {
			if (asyncHandle != null) {
				asyncHandle.asHandle().close(keepAliveClose);
				asyncHandle = null;
			}
			throw 'Failed to create uv_timer_t deadline handle: $timerErr';
		}
		timerHandle = timer;
		timer.asHandle().unref();
	}

	public function wait(maxBlock:Float):Void {
		if (closed)
			return;
		if (maxBlock < 0) {
			// Haxe events already due: do not sleep in the poller
			stopDeadlineTimer();
			uvLoop.run(Uv.RUN_NOWAIT);
			return;
		}
		if (maxBlock > 0)
			armDeadlineTimer(maxBlock);
		else
			stopDeadlineTimer();
		// Ref async for the blocking poll so wait(0)/wait(t) cannot busy-spin
		// when only unref'd driver handles exist.
		final async = asyncHandle;
		if (async != null)
			async.asHandle().ref();
		uvLoop.run(Uv.RUN_ONCE);
		if (async != null)
			async.asHandle().unref();
		stopDeadlineTimer();
	}

	public function wake():Void {
		if (closed)
			return;
		if (asyncHandle != null)
			asyncHandle.send();
	}

	public function close():Void {
		if (closed)
			return;
		closed = true;
		stopDeadlineTimer();
		if (asyncHandle != null) {
			asyncHandle.asHandle().close(keepAliveClose);
			asyncHandle = null;
		}
		if (timerHandle != null) {
			timerHandle.asHandle().close(keepAliveClose);
			timerHandle = null;
		}
		// Drain close callbacks so loop_close can succeed
		uvLoop.run(Uv.RUN_NOWAIT);
		if (!isDefault) {
			final result = uvLoop.close();
			if (result != 0)
				Sys.println('Some async handlers have not been closed');
		}
	}

	public function hasExternalWork():Bool {
		return !closed && uvLoop.alive();
	}

	function armDeadlineTimer(maxBlock:Float) {
		if (timerHandle == null)
			return;
		var ms = Math.ceil(maxBlock * 1000);
		if (ms < 1)
			ms = 1;
		if (ms > 2147483647)
			ms = 2147483647;
		timerHandle.start(keepAliveTimer, Std.int(ms), 0);
	}

	function stopDeadlineTimer() {
		if (timerHandle != null)
			timerHandle.stop();
	}

	static function noopAsync(_:Star<UvAsync>):Void {}

	static function noopTimer(_:Star<UvTimer>):Void {}

	static function noopClose(_:Star<UvHandle>):Void {}
}
