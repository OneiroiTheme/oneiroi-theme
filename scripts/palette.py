import re
from typing import Any, Tuple
from utils import VIEW, parse_css, parse_conf, script_dir


class PLT:
    def __init__(self, plt_path: str, meta_path: str):
        self.css: VIEW = parse_css(plt_path)
        self.meta: VIEW = parse_conf(meta_path)

    @property
    def refs(self) -> list[Tuple[str, Any]]:
        pattern = re.compile(r"^var\((.*?)\)$")
        return [
            (k, match.group(1))
            for k, v in self.css.items()
            if isinstance(v, str) and (match := pattern.match(v))
        ]

    @property
    def css_extend(self) -> VIEW:
        css = self.css
        refs = self.refs
        csse: VIEW = {}
        for k, v in refs:
            csse[k] = css[v]
            csse[k + "-s"] = css[v + "-s"]
        return css | csse

    @property
    def view(self) -> VIEW:
        def css_convert(view: VIEW, rule_path=script_dir + "/format.ini"):
            rules = parse_conf(rule_path)
            for K, V in rules["rules"].items():
                view = {re.compile(K).sub(V, k): v for k, v in view.items()}
            return view

        view = css_convert(self.css_extend) | self.meta["metadata"]
        return view
