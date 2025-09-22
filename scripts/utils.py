import os
import re
import configparser
import json
from typing import Any, Tuple

script_dir = os.path.dirname(os.path.abspath(__file__))
PLT_ROOT = os.path.abspath(script_dir + "/../palettes")
PLT_META_ROOT = os.path.abspath(script_dir + "/pltmeta")
PKG_ROOT = os.path.abspath(script_dir + "/../themes")
BUILD_PATH = os.path.abspath(script_dir + "/_build")
VIEW_PATH = os.path.abspath(script_dir + "/_build")
TPL_CONFIG_PATH = "/.template/configure.json"
README_LOCAL_TEMPLATES_PATH = "/.template/docs"
README_DEFAULT_TEMPLATES_PATH = f"{script_dir}/readme_templates"

TPL_SECTION_NAME: str = "tpl"
PLT_SECTION_NAME: str = "plt"
READABLE_SECTION_NAME: str = "readme"

MUSTACHE_PATTERN = "s|{{${key}}}|${value}|"
MSTP = MUSTACHE_PATTERN

KV = Tuple[str, Any]
VIEW = dict


def scan_d(path: str) -> list[str]:
    try:
        return [f for f in os.listdir(path) if os.path.isdir(os.path.join(path, f))]
    except (FileNotFoundError, NotADirectoryError, PermissionError):
        return []


def scan_f(path: str, ext: str) -> list[str]:
    try:
        return [
            os.path.splitext(f)[0]
            for f in os.listdir(path)
            if os.path.isfile(os.path.join(path, f)) and f.endswith(ext)
        ]
    except (FileNotFoundError, NotADirectoryError, PermissionError):
        return []


def parse_conf(path: str) -> VIEW:
    config = configparser.ConfigParser()
    config.read(path, encoding="utf-8")
    d = {section: dict(config.items(section)) for section in config.sections()}
    return d


def parse_css(path: str) -> VIEW:
    with open(path, "r", encoding="utf-8") as f:
        content = f.read()
    blocks = re.findall(r"([^{]+)\{([^}]+)\}", content, re.S)
    result = {}

    for selectors, body in blocks:
        for selector in selectors.split(","):
            selector = selector.strip()
            if not selector:
                continue

            properties = {}
            for prop, value in re.findall(r"(--[\w-]+)\s*:\s*([^;]+);", body):
                properties[prop.strip()] = value.strip()

            if selector == ":root":
                result.update(properties)
            else:
                clean_name = selector.lstrip(".")
                result[clean_name] = properties
    return result


def parse_json(path: str) -> VIEW:
    with open(path, "r", encoding="utf-8") as f:
        data = json.load(f)
    return data


def flatten_dict(d: VIEW, parent_key="", sep=".") -> list[KV]:
    items = []
    for k, v in d.items():
        new_key = f"{parent_key}{sep}{k}" if parent_key else k
        if isinstance(v, dict):
            items.extend(flatten_dict(v, new_key, sep=sep))
        else:
            items.append((new_key, v))
    return items


def regsub(text: str, ptn: str, view: None | KV = None) -> str:
    def reg(s: str, pattern: str) -> str:
        parts = pattern.split("|")
        if len(parts) < 3:
            raise ValueError("Pattern must contain at least two '|' characters.")
        regex, repl = parts[1], parts[2]
        return re.sub(regex, repl, s)

    if view is not None:
        ptn = ptn.replace("${key}", view[0])
        ptn = ptn.replace("${value}", view[1])

    return reg(text, ptn)


def mustache_render(template: str, view: dict, default: None | str = None) -> str:
    d: list[KV] = flatten_dict(view)
    if default is not None:
        vars_found = re.findall(r"\{\{(.*?)\}\}", template)
        keys = {k for k, _ in d}
        for var in vars_found:
            if var not in keys:
                d.append((var, default))
    for i in d:
        template = regsub(template, MSTP, i)
    return template


def render(
    input: str, view: VIEW | None, type: str = "mustache", default: None | str = None
) -> str:
    if view is None:
        return input
    if type == "mustache":
        return mustache_render(input, view, default)
    return input
