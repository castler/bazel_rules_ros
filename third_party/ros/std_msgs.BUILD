cc_library(
    name = "builtin_std_msgs",
    hdrs = [":generate_header_h"] + glob(["include/**/*.h"]),
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
)

genrule(
    name = "generate_header_h",
    srcs = ["msg/Header.msg"],
    outs = ["std_msgs/Header.h"],
    cmd = "echo $(location @gencpp//:gencpp)",
    tools = ["@gencpp//:gencpp"],
)
