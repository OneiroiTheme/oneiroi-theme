from utils import (
    VIEW,
    PKG_ROOT,
    VIEW_PATH,
    BUILD_PATH,
    TPL_PATH,
    scan_d,
    scan_f,
    vreg,
    parse_json,
)


def build_pkg(pkg_path: str, view: VIEW, tpl_path: str, output_path: str):
    conf = parse_json(tpl_path)
    input = conf["input"]
    output = conf["output"]

    if isinstance(input, str):
        input = [input]
    if isinstance(output, str):
        output = [output]

    if len(input) != len(output):
        raise ValueError(f"format error, check '{tpl_path}'")
    for i, o in zip(input, output):
        i = pkg_path + vreg(i, view)
        o = output_path + vreg(o, view)
        with open(i, "r", encoding="utf-8") as f_in:
            data = f_in.read()
        data = vreg(data, view)
        with open(o, "w", encoding="utf-8") as f_out:
            f_out.write(data)


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
