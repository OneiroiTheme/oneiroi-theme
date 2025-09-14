import re
from typing import Tuple
from utils import VIEW, parse_css, parse_conf, script_dir


class PLT:
    def __init__(self, plt_path: str):
        self.css: VIEW = parse_css(plt_path)

    @property
    def refs(self) -> list[Tuple[str, str]]:
        # Resolve variable references
        pattern = re.compile(r"^var\((.*?)\)$")

        def resolve(k):
            while m := pattern.match(self.css[k]):
                k = m.group(1)
            return k

        return [(k, resolve(k)) for k in self.css if pattern.match(self.css[k])]

    @property
    def css_resolved(self) -> VIEW:
        css = self.css
        refs = self.refs
        csse: VIEW = {}
        for k, v in refs:
            csse[k] = css[v]
        return css | csse

    @property
    def view(self) -> VIEW:
        # Resolve variable name rules
        def css_convert(view: VIEW, rule_path=script_dir + "/format.ini"):
            rules = parse_conf(rule_path)
            for K, V in rules["rules"].items():
                view = {re.compile(K).sub(V, k): v for k, v in view.items()}
            return view

        view = css_convert(self.css_resolved)
        return view
