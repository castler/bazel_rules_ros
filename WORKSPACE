workspace(name="bazel_ros")

new_http_archive(
    name = "ros",
    strip_prefix = "ros-1.14.3",
    urls = ["https://github.com/ros/ros/archive/1.14.3.tar.gz"],
    sha256 = "3d0d6b6f1d5fee4243c94a73eaeb73e971ba6649ddb04c5ff21d90a8d49fc36b",
    build_file = "third_party/ros/ros.BUILD",
)

new_http_archive(
    name = "roscpp_core",
    strip_prefix = "roscpp_core-d5d914cce10aa27974ddfae4afc6f71b64a595e0",
    urls = ["https://github.com/ros/roscpp_core/archive/d5d914cce10aa27974ddfae4afc6f71b64a595e0.tar.gz"],
    sha256 = "f81361385f7261c1b4af4de1d49cecfeb87d0952f3938d3d6cd9825b8e72adff",
    build_file = "third_party/ros/roscpp_core.BUILD",
)

new_http_archive(
    name = "ros_comm",
    strip_prefix = "ros_comm-c99fa76b1edc3417aa1404f40f4ef452ee662f9f",
    urls = ["https://github.com/ros/ros_comm/archive/c99fa76b1edc3417aa1404f40f4ef452ee662f9f.tar.gz"],
    sha256 = "529fdbed4da2f0a306c197765eab7a184377f995eadfd832198195552eeb9991",
    build_file = "third_party/ros/ros_comm.BUILD",
)

new_http_archive(
    name = "genmsg",
    strip_prefix = "genmsg-0bfdc5acf26fc2ab5cf085acf53d3f417706d38e",
    urls = ["https://github.com/ros/genmsg/archive/0bfdc5acf26fc2ab5cf085acf53d3f417706d38e.tar.gz"],
    sha256 = "8d9eb6653b142b3097e94e59a068e0acd4972110b2be3d2f74dc15255a146fda",
    build_file = "third_party/ros/genmsg.BUILD",
)

new_http_archive(
    name = "gencpp",
    strip_prefix = "gencpp-b41ee3060badd660662e21cd9d4f81971c87a420",
    urls = ["https://github.com/ros/gencpp/archive/b41ee3060badd660662e21cd9d4f81971c87a420.tar.gz"],
    sha256 = "7df31ecc85669d8664339b2eef35d65662315b89da2d8822382533a8e172435c",
    build_file = "third_party/ros/gencpp.BUILD",
)

new_http_archive(
    name = "std_msgs",
    strip_prefix = "std_msgs-474568b32881c81f6fb962a1b45a7d60c4db9255",
    urls = ["https://github.com/ros/std_msgs/archive/474568b32881c81f6fb962a1b45a7d60c4db9255.tar.gz"],
    sha256 = "d39866a32e9d4f4d29276bd1ed7943cb52933c43531910d0c759580d749f9995",
    build_file = "third_party/ros/std_msgs.BUILD"
)

http_archive(
    name = "glog",
    strip_prefix = "glog-2f493d292c92abf16ebd46cfd0cc0bf8eef5724d",
    urls = ["https://github.com/google/glog/archive/2f493d292c92abf16ebd46cfd0cc0bf8eef5724d.tar.gz"],
    sha256 = "adc7deaf8daa535bbc2f18a71fa6d07ad88f4bd4cb114271b8367a2f323703d3"
)

git_repository(
    name = "com_github_nelhage_rules_boost",
    commit = "5e746bc69de4142ce467b372339ab110a8d67781",
    remote = "https://github.com/nelhage/rules_boost",
)

load("@com_github_nelhage_rules_boost//:boost/boost.bzl", "boost_deps")
boost_deps()

http_archive(
    name = "com_github_gflags_gflags",
    sha256 = "6e16c8bc91b1310a44f3965e616383dbda48f83e8c1eaa2370a215057b00cabe",
    strip_prefix = "gflags-77592648e3f3be87d6c7123eb81cbad75f9aef5a",
    urls = [
        "https://mirror.bazel.build/github.com/gflags/gflags/archive/77592648e3f3be87d6c7123eb81cbad75f9aef5a.tar.gz",
        "https://github.com/gflags/gflags/archive/77592648e3f3be87d6c7123eb81cbad75f9aef5a.tar.gz",
    ],
)
