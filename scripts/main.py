import argparse

from build import Build
from mkview import Mkview
from mkreadme import MKreadme


def main():
    parser = argparse.ArgumentParser()
    commands = parser.add_subparsers(dest="command", required=True, help="commands")

    build = commands.add_parser("build", help="Build packages")
    build.add_argument("pkg", nargs="*", default=True, help="specific name")
    build.add_argument("-P", "--plt", nargs="*", default=True, help="specific plt")
    build.add_argument("--pkgpath", metavar="<path>", help="packages root path")
    build.add_argument("--viewpath", metavar="<path>", help="view root path")
    build.add_argument("--outputpath", metavar="<path>", help="packages output path")

    mkview = commands.add_parser("mkview", help="Make view dicts from css")
    mkview.add_argument("plt", nargs="*", default=True, help="specific name")
    mkview.add_argument("--pltpath", metavar="<path>", help="palettes root path")
    mkview.add_argument("--metapath", metavar="<path>", help="metadate root path")
    mkview.add_argument("--outputpath", metavar="<path>", help="view output path")

    mkreadme = commands.add_parser("mkreadme", help="Make README.md for packages")
    mkreadme.add_argument("pkg", nargs="*", default=True, help="specific name")
    mkreadme.add_argument("--pkgpath", metavar="<path>", help="packages root path")
    mkreadme.add_argument("--outputpath", metavar="<path>", help="packages output path")

    parser.add_argument("-v", "--verbose", action="store_true", help="Verbose")
    args = parser.parse_args()
    if args.command == "build":
        Build(args.pkg, args.plt, args.pkgpath, args.viewpath, args.outputpath)
        # switch(args.theme, args.packages, args.distransparent)
    elif args.command == "mkview":
        Mkview(args.plt, args.pltpath, args.metapath, args.outputpath)
    elif args.command == "mkreadme":
        MKreadme(args.pkg, args.pkgpath, args.outputpath)


if __name__ == "__main__":
    main()
