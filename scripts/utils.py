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
TPL_PATH = "/.template/configure.json"

MUSTACHE_PATTERN = "s|{{${key}}}|${value}|"
MSTP = MUSTACHE_PATTERN

KV = Tuple[str, Any]
VIEW = dict


def scan_d(path: str) -> list[str]:
    return [f for f in os.listdir(path) if os.path.isdir(os.path.join(path, f))]


def scan_f(path: str, ext: str) -> list[str]:
    return [
        os.path.splitext(f)[0]
        for f in os.listdir(path)
        if os.path.isfile(os.path.join(path, f)) and f.endswith(ext)
    ]


def parse_conf(path: str) -> VIEW:
    config = configparser.ConfigParser()
    config.read(path, encoding="utf-8")
    d = {section: dict(config.items(section)) for section in config.sections()}
    return d


def parse_css(path: str) -> VIEW:
    with open(path, "r", encoding="utf-8") as f:
        content = f.read()
    pattern = re.compile(r"(--[\w-]+):\s*(#[0-9A-Fa-f]{3,6}|var\(--[\w-]+\));")
    variables = {}
    for match in pattern.finditer(content):
        key = match.group(1)
        value = match.group(2)
        variables[key] = value
    return variables


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


def regsub(input: str, ptn: str, view: None | KV = None) -> str:
    def _reg(input_: str, pattern: str) -> str:
        parts = pattern.split("|")
        if len(parts) < 3:
            raise ValueError("Pattern must contain at least two '|' characters.")
        return re.sub(parts[1], parts[2], input_)

    if view is None:
        return _reg(input, ptn)
    else:
        ptn = ptn.replace("${key}", view[0])
        ptn = ptn.replace("${value}", view[1])
        return _reg(input, ptn)


def vreg(input: str, view: VIEW, ptn: str = MSTP) -> str:
    d = flatten_dict(view)
    for i in d:
        input = regsub(input, ptn, i)
    return input
