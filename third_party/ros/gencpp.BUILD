py_binary(
    name = "gencpp_runner",
    srcs = glob(["scripts/*.py"]),
    deps = ["@genmsg_archive//:genmsg",":gencpp"],
    data = [":gen_templates"],
    main = "gen_cpp.py",
    visibility = ["//visibility:public"],
)

py_library(
    name = "gencpp",
    srcs = glob(["src/**/*.py"]),
    imports = ["src"]
)

filegroup(
  name = "gen_templates",
  srcs = [
    "scripts/msg.h.template",
    "scripts/srv.h.template"
  ],
)
