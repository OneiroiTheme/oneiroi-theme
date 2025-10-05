import os
import json
from palette import PLT
from utils import (
    PLT_ROOT,
    VIEW_PATH,
    scan_f,
)


def Mkview(
    plt: list[str] | bool,
    plt_path: str | None = None,
    output_path: str | None = None,
):
    plt_path = plt_path or PLT_ROOT
    output_path = output_path or VIEW_PATH

    if isinstance(plt, bool):
        plt = scan_f(plt_path, ".css")
    for _plt in plt:
        p = plt_path + "/" + _plt + ".css"
        o = output_path + "/" + _plt + ".json"

        view = PLT(p).view
        os.makedirs(os.path.dirname(o), exist_ok=True)
        with open(o, "w", encoding="utf-8") as f:
            json.dump(view, f, ensure_ascii=False, indent=4)
