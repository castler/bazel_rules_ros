
load("@bazel_skylib//:lib.bzl", "paths")

RosGenProvider = provider()

def _genmsg_outs(srcs, ros_package_name, extension):
    """ Given a list of *.msg files, return the expected paths
    to the generated code with that extension. """

    (extension in ['.py', '.h']
        or fail('Unknown extension %s' % extension))

    msg_names = []
    for item in srcs:
        if not item.endswith('.msg'):
            fail('%s does not end in .msg' % item)
        item_name = paths.basename(item)[:-len('.msg')]

        if extension == '.py':
            item_name = '_' + item_name

        msg_names.append(item_name)

    outs = [
        paths.join(ros_package_name, msg_name + extension)
        for msg_name in msg_names
    ]

    if extension == '.py':
        outs += [
            paths.join(ros_package_name, '__init__.py'),
        ]

    return outs

def _gencpp_impl(ctx):
    """Implementation for the genpy rule. Shells out to the scripts
    shipped with genpy."""

    srcpath = ctx.files.srcs[0].dirname
    outpath = ctx.outputs.outs[0].dirname

    dep_flags = []
    dep_srcs = []
    for dep in ctx.attr.deps:
        dep_srcs = dep_srcs + dep[RosGenProvider].srcs
        dep_flags.append('-I')
        dep_flags.append('%s:%s' % (dep[RosGenProvider].package_name ,dep[RosGenProvider].srcs[0].dirname))

    # Generate the actual messages
    for i in range(len(ctx.outputs.outs)):
        ctx.action(
        inputs = [ctx.files.srcs[i]] + dep_srcs + ctx.files.srcs,
        outputs = [ctx.outputs.outs[i]],
	      executable = ctx.executable._gen_script,
        arguments = [
            '-o', outpath,
            '-p', ctx.attr.ros_package_name, # Include path for the current package
            '-I', '%s:%s' % (ctx.attr.ros_package_name, srcpath),
  #          '-e', '%s' % (ctx.executable._gen_script.dirname+"/gencpp_runner.runfiles/gencpp_archive/scripts"),
        ] + dep_flags + [
           ctx.files.srcs[i].path
        ],
        )

    return [RosGenProvider(package_name=ctx.attr.ros_package_name, srcs=ctx.files.srcs)]


_genpy = rule(
    implementation = _gencpp_impl,
    output_to_genfiles = True,
    attrs = {
        'srcs': attr.label_list(allow_files=True),
        'ros_package_name': attr.string(),
        'deps': attr.label_list(allow_empty=True),
        '_gen_script': attr.label(
            default=Label('@gencpp_archive//:gencpp_runner'),
            executable=True,
            cfg='host'),
        'outs': attr.output_list(),
    },
)

def generate_messages(name,
                      srcs=None,
                      ros_package_name=None,
                      deps=None,
                      ):
    """ Wraps all message generation functionality. Uses the _genpy
    and _gencpp to shell out to the code generation scripts, then wraps
    the resulting files into Python and C++ libraries.
    We use macros to hide some of the book-keeping of input & output
    files. """

    if not srcs:
        fail('srcs is required (*.msg files).')
    if not ros_package_name:
        fail('ros_package_name is required.')

    outs = _genmsg_outs(srcs, ros_package_name, '.h')

    gen_dep = []
    if deps:
      for a in deps:
        gen_dep.append(Label(a + "_gencppout"))

    cc_dep = []
    if deps:
        cc_dep = deps

    _genpy(
        name = name+'_gencppout',
        srcs = srcs,
        ros_package_name = ros_package_name,
        outs = outs,
        deps = gen_dep,
    )

    return native.cc_library(
        name = name,
        hdrs = outs,
        deps = cc_dep,
        includes = [""]
    )
