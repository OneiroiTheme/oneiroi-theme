import re
from utils import VIEW, TPL_SECTION_NAME, parse_json, render


class PORT:
    def __init__(self, root: str, conf_path: str):
        self.root = root
        self._config_path = conf_path
        pass

    @property
    def meta(self) -> VIEW:
        m = parse_json(self._config_path)
        REPO_SECTION_NAME = "repository"
        if m[REPO_SECTION_NAME]["type"] == "git":
            git_url = m["repository"]["url"]
            match = re.search(
                r"(?:github\.com[:/])([^/]+)/([^/]+?)(?:\.git)?$", git_url
            )
            if match:
                publisher, repo = match.groups()
                bare_url = f"https://github.com/{publisher}/{repo}"
                m[REPO_SECTION_NAME]["publisher"] = publisher
                m[REPO_SECTION_NAME]["repo"] = repo
                m[REPO_SECTION_NAME]["bareurl"] = bare_url
        return m

    @property
    def conf(self) -> VIEW | None:
        return self.meta.get("templates", None)

    def render_conf(
        self, view: VIEW | None = None, output_path: str | None = None
    ) -> list[tuple[str, str, str]]:
        output_path = output_path or self.root
        meta = self.meta
        conf = meta.get("templates", None)
        l = []
        if conf is None:
            return l
        if view is not None:
            view[TPL_SECTION_NAME] = meta
        if not isinstance(conf, list):
            conf = [conf]

        for c in conf:
            type: str = c["type"]
            input: str = c["input"]
            output: str = c["output"]
            input = self.root + render(input, view, type)
            output = output_path + render(output, view, type)
            l.append((input, output, type))
        return l

    def build(self, view: VIEW, output_path: str):
        conf = self.render_conf(view, output_path)
        for input, output, type in conf:
            with open(input, "r", encoding="utf-8") as f_in:
                data = f_in.read()
            data = render(data, view, type)
            with open(output, "w", encoding="utf-8") as f_out:
                f_out.write(data)
        return conf
