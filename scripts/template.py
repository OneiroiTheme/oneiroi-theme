import re
from utils import VIEW, parse_json, render

DEFAULT_VIEW = [
    {"type": "plt", "section_name": None},
    {"type": "pltmeta", "section_name": "plt"},
]
VIEW_TYPE_NAME = "type"
VIEW_SECTION_NAME = "section_name"


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
    ) -> list[tuple[str, str, str, list[tuple[str, str | None]]]]:
        output_path = output_path or self.root
        meta = self.meta
        conf = meta.get("templates", None)
        l = []
        if conf is None:
            return l
        if not isinstance(conf, list):
            conf = [conf]

        for c in conf:
            type: str = c["type"]
            input: str = c["input"]
            output: str = c["output"]
            views: list[dict | str] | None = c.get("views", None)
            views = views or DEFAULT_VIEW
            if isinstance(views, dict):
                views = [views]
            input = self.root + render(input, view, type)
            output = output_path + render(output, view, type)
            v: list[tuple[str, str | None]] = []
            for i in views:
                if isinstance(i, str):
                    v.append((i, None))
                else:
                    v.append((i[VIEW_TYPE_NAME], i.get(VIEW_SECTION_NAME, None)))
            l.append((input, output, type, v))
        return l
