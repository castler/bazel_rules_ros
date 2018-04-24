cc_library(
    name = "console_bridge",
    hdrs = glob(["include/**/*.h"]),
    srcs = glob(["src/**/*.cpp"])+[':generate_export_header'],
    alwayslink=1,
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
)

genrule(
    name = "generate_export_header",
    outs = ["console_bridge_export.h"],
    cmd = "echo '#define CONSOLE_BRIDGE_DLLAPI __attribute__((visibility(\"default\")))' > $(OUTS)"
)
