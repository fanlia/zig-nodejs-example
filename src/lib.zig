const std = @import("std");
const c = @import("c.zig");

export fn napi_register_module_v1(env: c.napi_env, exports: c.napi_value) c.napi_value {
    var napi_function: c.napi_value = undefined;
    if (c.napi_create_function(env, null, 0, greet, null, &napi_function) != c.napi_ok) {
        _ = c.napi_throw_error(env, null, "failed to create function");
    }
    if (c.napi_set_named_property(env, exports, "greet", napi_function) != c.napi_ok) {
        _ = c.napi_throw_error(env, null, "failed to add function to exports");
    }
    return exports;
}

fn greet(env: c.napi_env, info: c.napi_callback_info) callconv(.C) c.napi_value {
    _ = info;
    const value = "hello world";
    var result: c.napi_value = undefined;
    if (c.napi_create_string_utf8(env, value, value.len, &result) != c.napi_ok) {
        _ = c.napi_throw_error(env, null, "failed to create string");
    }
    return result;
}
