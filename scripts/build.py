from template import PORT
from utils import (
    VIEW,
    PKG_ROOT,
    VIEW_PATH,
    TPL_CONFIG_PATH,
    scan_d,
    scan_f,
    parse_json,
)


def Build(
    pkg: list[str] | bool,
    plt: list[str] | bool,
    pkg_path: str | None = None,
    view_path: str | None = None,
    output_path: str | None = None,
):
    if isinstance(pkg, bool):
        pkg = scan_d(PKG_ROOT)
    if isinstance(plt, bool):
        plt = scan_f(VIEW_PATH, ".json")
    pkg_path = pkg_path or PKG_ROOT
    view_path = view_path or VIEW_PATH
    output_path = output_path or PKG_ROOT

    for _plt in plt:
        plt_view = view_path + "/" + _plt + ".json"
        plt_view = parse_json(plt_view)
        for _pkg in pkg:
            _pkg_path = pkg_path + "/" + _pkg
            _tpl_path = _pkg_path + TPL_CONFIG_PATH
            _out_path = output_path + "/" + _pkg
            port = PORT(_pkg_path, _tpl_path)
            port.build(plt_view, _out_path)


if __name__ == "__main__":
    Build(["alacritty"], ["dream"])
    pass
