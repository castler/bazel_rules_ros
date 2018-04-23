load("@bazel_ros//tools/ros:message_generation.bzl", "generate_messages")

# Depends on roscpp_core
cc_library(
    name = "roscpp",
    srcs = [":generate_config_h"] + glob(["clients/roscpp/src/libros/**/*.cpp"]),
    hdrs = [":generate_ros_common_h"] + glob(["clients/roscpp/include/**/*.h"]),
    includes = [
        "clients/roscpp/src/libros",
        "clients/roscpp/include",
        "clients/roscpp/include/ros"
    ],
    deps = [
        ":rosconsole",
        ":xmlrpcpp",
        "@roscpp_core//:roscpp_core",
        "@boost//:thread",
        "@boost//:scope_exit",
        "@ros_comm_msgs//:builtin_ros_comm_msgs",
        ":builtin_ros_comm_msgs_whatever"
    ],
    visibility = ["//visibility:public"],
)

cc_library(
    name = "rosconsole",
    srcs = glob(["tools/rosconsole/src/**/*.cpp"]),
    hdrs = glob(["tools/rosconsole/include/**/*.h"]),
    deps = [
        "@roscpp_core//:roscpp_core",
        "@boost//:math",
        "@glog//:glog"
    ],
    strip_include_prefix = "tools/rosconsole/include",
)

cc_library(
    name = "xmlrpcpp",
    srcs = glob(["utilities/xmlrpcpp/src/**/*.cpp"]),
    hdrs = glob(["utilities/xmlrpcpp/include/**/*.h"]),
    deps = ["@roscpp_core//:roscpp_core",],
    strip_include_prefix = "utilities/xmlrpcpp/include",
)


genrule(
    name = "generate_ros_common_h",
    srcs = ["clients/roscpp/include/ros/common.h.in"],
    outs = ["clients/roscpp/include/ros/common.h"],
    cmd = "sed -e 's/@roscpp_VERSION_MAJOR@/0/g' \
               -e 's/@roscpp_VERSION_MINOR@/1/g' \
               -e 's/@roscpp_VERSION_PATCH@/2/g' \
               $(SRCS) > $(OUTS)"
)

genrule(
    name = "generate_config_h",
    srcs = ["clients/roscpp/src/libros/config.h.in"],
    outs = ["clients/roscpp/src/libros/config.h"],
    cmd = "sed -e 's/#cmakedefine HAVE_IFADDRS_H/#define HAVE_IFADDRS_H 1/g' \
               -e 's/#cmakedefine HAVE_TRUNC//g' \
               -e 's/#cmakedefine HAVE_EPOLL//g' \
               $(SRCS) > $(OUTS)"
)

generate_messages(
    name = "builtin_ros_comm_msgs_whatever",
    srcs = glob(["clients/roscpp/msg/*.msg"]),
    ros_package_name = "roscpp",
)
