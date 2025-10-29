import re
from utils import VIEW, parse_css, parse_conf, script_dir


class PLT:
    def __init__(self, plt_path: str):
        self.css: VIEW = parse_css(plt_path)

    @property
    def resolved_css(self) -> VIEW:
        css = self.css
        pattern = re.compile(r"^var\((--[\w-]+)\)$")
        top_level_vars = {k: v for k, v in css.items() if isinstance(v, str)}

        def resolve_value(v):
            if isinstance(v, str):
                m = pattern.match(v)
                if m:
                    return top_level_vars.get(m.group(1), v)
                return v
            elif isinstance(v, dict):
                return {kk: resolve_value(vv) for kk, vv in v.items()}
            else:
                return v

        return {k: resolve_value(v) for k, v in css.items()}

    @property
    def view(self) -> VIEW:
        # Resolve variable name rules
        rule_path = script_dir + "/format.ini"
        rules = parse_conf(rule_path)

        def apply_rules(d: dict) -> dict:
            new_d = {}
            for k, v in d.items():
                for K, V in rules["rules"].items():
                    k = re.compile(K).sub(V, k)
                if isinstance(v, dict):
                    new_d[k] = apply_rules(v)
                else:
                    new_d[k] = v
            return new_d

        return apply_rules(self.resolved_css)
