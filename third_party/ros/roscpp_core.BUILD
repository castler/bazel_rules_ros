# Used to build all libraries mentioned in https://github.com/ros/roscpp_core
cc_library(
    name = "roscpp_core",
    deps = [
        ":cpp_common",
        ":roscpp_serialization",
        ":roscpp_traits",
        ":rostime"
    ],
    visibility = ["//visibility:public"],
)

cc_library(
    name = "cpp_common",
    srcs = glob(["cpp_common/src/libros/**/*.cpp"]),
    hdrs = glob(["cpp_common/include/**/*.h"]),
    strip_include_prefix = "cpp_common/include",
    visibility = ["//visibility:private"],
)

cc_library(
    name = "roscpp_serialization",
    srcs = glob(["roscpp_serialization/src/libros/**/*.cpp"]),
    hdrs = glob(["roscpp_serialization/include/**/*.h"]),
    strip_include_prefix = "roscpp_serialization/include",
    deps = [
        "@boost//:array",
        "@boost//:mpl",
        "@boost//:call_traits",
        "@boost//:signals2",
    ],
    visibility = ["//visibility:private"],
)

cc_library(
    name = "roscpp_traits",
    hdrs = glob(["roscpp_traits/include/**/*.h"]),
    strip_include_prefix = "roscpp_traits/include",
    visibility = ["//visibility:private"],
)

cc_library(
    name = "rostime",
    srcs = glob(["rostime/src/libros/**/*.cpp"]),
    hdrs = glob(["rostime/include/**/*.h"]),
    strip_include_prefix = "rostime/include",
    deps = [
        "@boost//:date_time",
        "@boost//:system",
        "@boost//:thread",
    ],
    visibility = ["//visibility:private"],
)
