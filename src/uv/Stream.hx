package uv;

import uv.Native.UvHandle;
import uv.Native.UvStream;
import uv.Native.UvWrite;
import uv.Native.UvShutdown;

@:dce
abstract Stream(Stream_t) from Stream_t to Stream_t {
	@:to public inline function asHandle():Handle
		return this;

	public inline function setData<T>(v:Data<T>)
		this.data = cast v;

	public inline function getData<T>():Data<T>
		return cast this.data;

	public inline function shutdown(req:Shutdown, cb:cpp.Callable<cpp.RawPointer<UvShutdown>->Int->Void>)
		return Uv.shutdown(req, this, cb);

	public inline function listen(backlog:Int, cb:cpp.Callable<cpp.RawPointer<UvStream>->Int->Void>)
		return Uv.listen(this, backlog, cb);

	public inline function accept(client:Stream)
		return Uv.accept(this, client);

	public inline function readStart(alloc_cb:cpp.Callable<cpp.RawPointer<UvHandle>->cpp.SizeT->cpp.Star<Buf_t>->Void>,
			read_cb:cpp.Callable<cpp.RawPointer<UvStream>->SSizeT->cpp.ConstStar<Buf_t>->Void>)
		return Uv.read_start(this, alloc_cb, read_cb);

	public inline function readStop()
		return Uv.read_stop(this);

	public inline function write(req:Write, bufs:Buf, nbufs:UInt, cb:cpp.Callable<cpp.RawPointer<UvWrite>->Int->Void>)
		return Uv.write(req, this, bufs, nbufs, cb);

	public inline function tryWrite(bufs:Buf, nbufs:UInt)
		return Uv.try_write(this, bufs, nbufs);

	public inline function isWritable()
		return Uv.is_writable(this) != 0;

	public inline function isReadable()
		return Uv.is_readable(this) != 0;
}
