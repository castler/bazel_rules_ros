load("@rules_ros//tools/ros:message_generation.bzl", "generate_messages")

package(
    default_visibility = ["//visibility:public"],
)

cc_library(
    name = "builtin_std_msgs",
    hdrs = glob(["include/**/*.h"]),
    deps = [":generate_header_h"]
)

generate_messages(
    name = "generate_header_h",
    srcs = glob(["msg/*.msg"]),
    ros_package_name = "std_msgs",
)
