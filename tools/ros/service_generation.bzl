
load("@bazel_skylib//:lib.bzl", "paths")
load("@rules_ros//tools/ros:message_generation.bzl", "RosGenProvider")

def _gensrv_outs(srcs, ros_package_name, extension):
    """ Given a list of *.srv files, return the expected paths
    to the generated code with that extension. """

    (extension in ['.py', '.h']
        or fail('Unknown extension %s' % extension))

    msg_names = []
    for item in srcs:
        if not item.endswith('.srv'):
            fail('%s does not end in .srv' % item)
        item_name = paths.basename(item)[:-len('.srv')]

        if extension == '.py':
            item_name = '_' + item_name

        msg_names.append(item_name)

    outs = []
    res ="Response"
    req ="Request"
    for msg_name in msg_names:
        outs.append(paths.join(ros_package_name, msg_name + extension))
        outs.append(paths.join(ros_package_name, msg_name + res + extension))
        outs.append(paths.join(ros_package_name, msg_name + req + extension))


    if extension == '.py':
        outs += [
            paths.join(ros_package_name, 'srv', '__init__.py'),
            paths.join(ros_package_name, '__init__.py'),

        ]
    return outs


def _gencpp_impl(ctx):
    """Implementation for the genpy rule. Shells outd to the scripts
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
    for i in range(len(ctx.files.srcs)):
        outshihi = _gensrv_outs([ctx.files.srcs[i].path], ctx.attr.ros_package_name, '.h')
        realout = []
        for j in range(len(ctx.outputs.outs)):
            for a in range(len(outshihi)):
              if outshihi[a] in ctx.outputs.outs[j].path:
                realout.append(ctx.outputs.outs[j])

        ctx.action(
            inputs= dep_srcs + ctx.files.srcs,
            outputs=realout,
            executable=ctx.executable._gen_script,
            arguments=[
                '-o', outpath,
                '-p', ctx.attr.ros_package_name,
                '-I', '%s:%s' % (ctx.attr.ros_package_name, srcpath), # Include path for the current package
#                '-e', '%s' % (ctx.executable._gen_script.dirname+"/gencpp_runner.runfiles/gencpp_archive/scripts"),
            ] + dep_flags + [
    	          ctx.files.srcs[i].path
            ],
        )

    return [RosGenProvider(package_name=ctx.attr.ros_package_name, srcs=ctx.files.srcs)]

_gensrv = rule(
    implementation=_gencpp_impl,
    output_to_genfiles=True,
    attrs={
        'srcs': attr.label_list(allow_files=True),
        'ros_package_name': attr.string(),
        'deps' : attr.label_list(allow_empty=True),
        '_gen_script': attr.label(
            default=Label('@gencpp_archive//:gencpp_runner'),
            executable=True,
            cfg='host'),
        'outs': attr.output_list(),
    },
)

def generate_services(name,
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
        fail('srcs is required (*.srv files).')
    if not ros_package_name:
        fail('ros_package_name is required.')

    outs = _gensrv_outs(srcs, ros_package_name, '.h')

    gen_dep = []
    if deps:
      for a in deps:
        gen_dep.append(Label(a + "_gencppout"))

    cc_dep = []
    if deps:
        cc_dep = deps

    _gensrv(
        name = name+'_gencppout',
        srcs = srcs,
        ros_package_name = ros_package_name,
        outs = outs,
        deps = gen_dep,
    )

    native.cc_library(
        name = name,
        hdrs = outs,
        deps = cc_dep,
        includes = [""],
    )
