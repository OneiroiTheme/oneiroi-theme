from template import PORT
from utils import (
    VIEW,
    PKG_ROOT,
    VIEW_PATH,
    TPL_CONFIG_PATH,
    PLT_META_ROOT,
    render,
    scan_d,
    scan_f,
    parse_conf,
    parse_json,
)


def get_plt_meta_section(plt_meta_path: str) -> VIEW:
    plt_meta: VIEW = parse_conf(plt_meta_path)["metadata"]
    plt_meta["theme_cap"] = plt_meta["theme"].title()
    plt_meta["plt_cap"] = plt_meta["plt"].title()
    return plt_meta


def build_port(
    p: PORT,
    outpath: str,
    plt_view_path: str,
    plt_meta_path: str,
    plts_path: str,
    tpls_path: str,
):

    def get_views(
        types: list[tuple[str, str | None]],
        port_meta: VIEW,
    ) -> VIEW:
        v: VIEW = {}
        for t, n in types:
            view: VIEW | list = {}
            if t == "port":
                view = port_meta
            elif t == "plt":
                view = parse_json(plt_view_path)
            elif t == "pltmeta":
                view = get_plt_meta_section(plt_meta_path)
            elif t == "plts":
                view = scan_f(plts_path, ".json")
            elif t == "ports":
                view = scan_d(tpls_path)
            if n or isinstance(view, list):
                v[n] = view
            else:
                v = v | view
        return v

    def build(input, output, type, view) -> None:
        with open(input, "r", encoding="utf-8") as f_in:
            data = f_in.read()
        data = render(data, view, type)
        with open(output, "w", encoding="utf-8") as f_out:
            f_out.write(data)

    port_meta = p.meta
    plt_view = parse_json(plt_view_path)
    for input, output, type, views in p.render_conf(plt_view, outpath):
        view = get_views(views, port_meta)
        build(input, output, type, view)


def Build(
    pkg: list[str] | bool,
    plt: list[str] | bool,
    pkg_path: str | None = None,
    view_path: str | None = None,
    meta_path: str | None = None,
    output_path: str | None = None,
):
    if isinstance(pkg, bool):
        pkg = scan_d(PKG_ROOT)
    if isinstance(plt, bool):
        plt = scan_f(VIEW_PATH, ".json")
    pkg_path = pkg_path or PKG_ROOT
    view_path = view_path or VIEW_PATH
    meta_path = meta_path or PLT_META_ROOT
    output_path = output_path or PKG_ROOT

    for _plt in plt:
        plt_view_path = view_path + "/" + _plt + ".json"
        plt_meta_path = meta_path + "/" + _plt + ".ini"
        for _pkg in pkg:
            _pkg_path = pkg_path + "/" + _pkg
            _tpl_path = _pkg_path + TPL_CONFIG_PATH
            _out_path = output_path + "/" + _pkg
            port = PORT(_pkg_path, _tpl_path)
            build_port(
                port, _out_path, plt_view_path, plt_meta_path, view_path, pkg_path
            )
