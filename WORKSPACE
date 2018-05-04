workspace(name="rules_ros")

git_repository(
    name = "com_github_nelhage_rules_boost",
    commit = "5e746bc69de4142ce467b372339ab110a8d67781",
    remote = "https://github.com/nelhage/rules_boost",
)

load("@com_github_nelhage_rules_boost//:boost/boost.bzl", "boost_deps")
boost_deps()

load("@rules_ros//tools/ros:workspace.bzl", "ros_deps")
ros_deps()
