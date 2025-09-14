from utils import (
    VIEW,
    PKG_ROOT,
    VIEW_PATH,
    BUILD_PATH,
    TPL_PATH,
    scan_d,
    scan_f,
    parse_json,
    mustache_render,
)


def build_pkg(pkg_path: str, view: VIEW, tpl_path: str, output_path: str):
    tpl_meta = parse_json(tpl_path)
    view["tpl"] = tpl_meta
    conf = tpl_meta["templates"]

    if not isinstance(conf, list):
        conf = [conf]
    for c in conf:
        try:
            Type = c["type"]
            input = c["input"]
            output = c["output"]

            if Type == "mustache":
                input = pkg_path + mustache_render(input, view)
                output = output_path + mustache_render(output, view)
                with open(input, "r", encoding="utf-8") as f_in:
                    data = f_in.read()
                data = mustache_render(data, view)
                with open(output, "w", encoding="utf-8") as f_out:
                    f_out.write(data)
        except ValueError:
            raise ValueError(f"format error, check '{tpl_path}'")


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
        view = view_path + "/" + _plt + ".json"
        view = parse_json(view)
        for _pkg in pkg:
            _pkg_path = pkg_path + "/" + _pkg
            _tpl_path = _pkg_path + TPL_PATH
            _out_path = output_path + "/" + _pkg
            build_pkg(_pkg_path, view, _tpl_path, _out_path)


if __name__ == "__main__":
    Build(["alacritty"], ["dream"])
    pass
