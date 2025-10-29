import os
import re
import configparser
import json
from typing import Any, Tuple
import chevron

script_dir = os.path.dirname(os.path.abspath(__file__))
PLT_ROOT = os.path.abspath(script_dir + "/../palettes")
PLT_META_ROOT = os.path.abspath(script_dir + "/pltmeta")
PKG_ROOT = os.path.abspath(script_dir + "/../themes")
BUILD_PATH = os.path.abspath(script_dir + "/_build")
VIEW_PATH = os.path.abspath(script_dir + "/_build")
TPL_CONFIG_PATH = "/.template/configure.json"
README_LOCAL_TEMPLATES_PATH = "/.template/docs"
README_DEFAULT_TEMPLATES_PATH = f"{script_dir}/readme_templates"

README_SECTION_NAME: str = "readme"

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


def render(
    input: str, view: VIEW | None, type: str = "mustache", default: None | str = None
) -> str:
    if view is None:
        return input
    if type == "mustache":
        return chevron.render(input, view)
    return input
