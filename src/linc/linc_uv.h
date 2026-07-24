#ifndef _LINC_UV_H_
#define _LINC_UV_H_

#include <uv.h>
#ifndef HXCPP_H
#include <hxcpp.h>
#endif
#include <stdlib.h>

namespace linc {
namespace uv {

	template <typename T>
	inline T *alloc_bytes(size_t n) {
		return (T *)malloc(n);
	}

	inline void free_ptr(void *p) {
		free(p);
	}

	inline uv_loop_t *alloc_loop() {
		return (uv_loop_t *)malloc(sizeof(uv_loop_t));
	}

	inline uv_tcp_t *alloc_tcp() {
		return (uv_tcp_t *)malloc(uv_handle_size(UV_TCP));
	}

	inline uv_pipe_t *alloc_pipe() {
		return (uv_pipe_t *)malloc(uv_handle_size(UV_NAMED_PIPE));
	}

	inline uv_timer_t *alloc_timer() {
		return (uv_timer_t *)malloc(uv_handle_size(UV_TIMER));
	}

	inline uv_async_t *alloc_async() {
		return (uv_async_t *)malloc(uv_handle_size(UV_ASYNC));
	}

	inline uv_connect_t *alloc_connect() {
		return (uv_connect_t *)malloc(uv_req_size(UV_CONNECT));
	}

	inline uv_write_t *alloc_write() {
		return (uv_write_t *)malloc(uv_req_size(UV_WRITE));
	}

	inline uv_shutdown_t *alloc_shutdown() {
		return (uv_shutdown_t *)malloc(uv_req_size(UV_SHUTDOWN));
	}

	inline uv_fs_t *alloc_fs() {
		return (uv_fs_t *)malloc(uv_req_size(UV_FS));
	}

	inline uv_getaddrinfo_t *alloc_getaddrinfo() {
		return (uv_getaddrinfo_t *)malloc(uv_req_size(UV_GETADDRINFO));
	}

	inline int tcp_bind(uv_tcp_t *handle, const struct sockaddr_in *addr, unsigned int flags) {
		return uv_tcp_bind(handle, (const struct sockaddr *)addr, flags);
	}

	inline int tcp_connect(uv_connect_t *req, uv_tcp_t *handle, const struct sockaddr_in *addr, uv_connect_cb cb) {
		return uv_tcp_connect(req, handle, (const struct sockaddr *)addr, cb);
	}

} // namespace uv
} // namespace linc

#endif //_LINC_UV_H_
