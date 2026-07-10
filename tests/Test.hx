package;

import cpp.*;
import haxe.io.Bytes;
import uv.*;
import uv.Native.UvHandle;
import uv.Native.UvStream;
import uv.Native.UvConnect;
import uv.Native.UvWrite;
import uv.Uv;

/**
	In-process TCP echo: server listens, client connects and writes a payload,
	server echoes it back, client verifies the round-trip, then the loop stops.
**/
class Test {
	static final PORT = 19087;
	static final PAYLOAD = "linc_uv-echo";

	static var loop:Loop;
	static var server:Tcp;
	static var serverClient:Tcp;
	static var client:Tcp;
	static var connectReq:Connect;
	static var clientWriteReq:Write;
	static var clientWriteBuf:Buf;
	static var serverWriteReq:Write;
	static var serverWriteBuf:Buf;
	static var bindAddr:SockAddrIn;
	static var destAddr:SockAddrIn;

	static var hasServerClient = false;
	static var echoed:Null<String>;
	static var connectStatus:Null<Int>;
	static var closed = 0;
	static var expectedCloses = 0;

	static function main() {
		loop = Loop.DEFAULT;

		bindAddr = new SockAddrIn();
		assertOk(bindAddr.ip4Addr("127.0.0.1", PORT), "ip4_addr bind");

		server = new Tcp();
		assertOk(server.init(loop), "server init");
		assertOk(server.bind(bindAddr, 0), "server bind");
		assertOk(server.nodelay(true), "server nodelay");
		assertOk(server.asStream().listen(128, Callable.fromStaticFunction(onConnection)), "listen");

		destAddr = new SockAddrIn();
		assertOk(destAddr.ip4Addr("127.0.0.1", PORT), "ip4_addr dest");

		client = new Tcp();
		assertOk(client.init(loop), "client init");
		connectReq = new Connect();
		assertOk(client.connect(connectReq, destAddr, Callable.fromStaticFunction(onConnect)), "connect");

		expectedCloses = 3;
		loop.run(Uv.RUN_DEFAULT);

		if (connectStatus == null)
			throw "connect callback never fired";
		if (connectStatus != 0)
			throw 'connect failed: $connectStatus ${Uv.err_name(connectStatus)}';
		if (echoed == null)
			throw "echo response never received";
		if (echoed != PAYLOAD)
			throw 'echo mismatch: got "$echoed" expected "$PAYLOAD"';

		trace('ok: echoed "$echoed"');
	}

	@:unreflective
	static function onConnection(stream:RawPointer<UvStream>, status:Int) {
		assertOk(status, "onConnection status");
		serverClient = new Tcp();
		hasServerClient = true;
		assertOk(serverClient.init(loop), "accept client init");
		assertOk((Native.stream(stream) : Stream).accept(serverClient.asStream()), "accept");
		assertOk(serverClient.asStream().readStart(Callable.fromStaticFunction(onServerAlloc), Callable.fromStaticFunction(onServerRead)),
			"server readStart");
	}

	@:unreflective
	static function onServerAlloc(handle:RawPointer<UvHandle>, suggestedSize:SizeT, buf:Star<Buf_t>) {
		final size:Int = cast suggestedSize;
		buf.base = untyped __cpp__('(char*){0}', Stdlib.nativeMalloc(size));
		buf.len = cast size;
	}

	@:unreflective
	static function onServerRead(handle:RawPointer<UvStream>, nread:SSizeT, buf:ConstStar<Buf_t>) {
		final n:Int = cast nread;
		final stream:Stream = Native.stream(handle);
		if (n > 0) {
			serverWriteReq = new Write();
			serverWriteBuf = new Buf();
			serverWriteBuf.alloc(n);
			serverWriteBuf.copyFrom(buf, n);
			assertOk(stream.write(serverWriteReq, serverWriteBuf, 1, Callable.fromStaticFunction(onServerWrite)), "server write");
		}
		if (n < 0) {
			if (n != cast Uv.EOF)
				throw 'server read error $n';
			closeHandle(stream.asHandle());
		}
		Buf.unmanaged(buf).free();
	}

	@:unreflective
	static function onServerWrite(req:RawPointer<UvWrite>, status:Int) {
		assertOk(status, "server write status");
		serverWriteBuf.freeBase();
	}

	@:unreflective
	static function onConnect(req:RawPointer<UvConnect>, status:Int) {
		connectStatus = status;
		assertOk(status, "onConnect");

		clientWriteReq = new Write();
		clientWriteBuf = new Buf();
		final bytes = Bytes.ofString(PAYLOAD);
		clientWriteBuf.alloc(bytes.length);
		clientWriteBuf.copyFromBytes(bytes, bytes.length);

		final stream = (Native.connect(req) : Connect).handle;
		assertOk(stream.write(clientWriteReq, clientWriteBuf, 1, Callable.fromStaticFunction(onClientWrite)), "client write");
		assertOk(stream.readStart(Callable.fromStaticFunction(onClientAlloc), Callable.fromStaticFunction(onClientRead)), "client readStart");
	}

	@:unreflective
	static function onClientWrite(req:RawPointer<UvWrite>, status:Int) {
		assertOk(status, "client write status");
		clientWriteBuf.freeBase();
	}

	@:unreflective
	static function onClientAlloc(handle:RawPointer<UvHandle>, suggestedSize:SizeT, buf:Star<Buf_t>) {
		final size:Int = cast suggestedSize;
		buf.base = untyped __cpp__('(char*){0}', Stdlib.nativeMalloc(size));
		buf.len = cast size;
	}

	@:unreflective
	static function onClientRead(handle:RawPointer<UvStream>, nread:SSizeT, buf:ConstStar<Buf_t>) {
		final n:Int = cast nread;
		final stream:Stream = Native.stream(handle);
		if (n > 0) {
			final out = Bytes.alloc(n);
			Buf.unmanaged(buf).copyToBytes(out, n);
			echoed = out.toString();
			stream.readStop();
			closeHandle(stream.asHandle());
			closeHandle(server.asHandle());
			if (hasServerClient)
				closeHandle(serverClient.asHandle());
		}
		if (n < 0) {
			if (n != cast Uv.EOF)
				throw 'client read error $n';
			closeHandle(stream.asHandle());
		}
		Buf.unmanaged(buf).free();
	}

	static function closeHandle(h:Handle) {
		if (h.isClosing())
			return;
		h.close(Callable.fromStaticFunction(onClose));
	}

	@:unreflective
	static function onClose(handle:RawPointer<UvHandle>) {
		closed++;
		if (closed >= expectedCloses)
			loop.stop();
	}

	static function assertOk(code:Int, what:String) {
		if (code != 0)
			throw '$what failed: $code ${Std.string(Uv.err_name(code))}';
	}
}
