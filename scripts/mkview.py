import os
import json
from palette import PLT
from utils import PLT_ROOT, PLT_META_ROOT, VIEW_PATH, scan_f


def Mkview(
    plt: list[str] | bool,
    plt_path: str | None = None,
    meta_path: str | None = None,
    output_path: str | None = None,
):
    plt_path = plt_path or PLT_ROOT
    meta_path = meta_path or PLT_META_ROOT
    output_path = output_path or VIEW_PATH

    if isinstance(plt, bool):
        plt = scan_f(plt_path, ".css")
    for _plt in plt:
        p = plt_path + "/" + _plt + ".css"
        m = meta_path + "/" + _plt + ".ini"
        o = output_path + "/" + _plt + ".json"

        palette = PLT(p, m)
        os.makedirs(os.path.dirname(o), exist_ok=True)
        with open(o, "w", encoding="utf-8") as f:
            json.dump(palette.view, f, ensure_ascii=False, indent=4)
