import re
from utils import VIEW, parse_json, render


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

    def render_io(
        self, input: str, output: str, type: str, view: VIEW, output_path: str
    ) -> tuple[str, str]:
        return (
            self.root + render(input, view, type),
            (output_path or self.root) + render(output, view, type),
        )
