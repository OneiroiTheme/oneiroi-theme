from template import PORT
from utils import (
    VIEW,
    PKG_ROOT,
    TPL_CONFIG_PATH,
    README_DEFAULT_TEMPLATES_PATH,
    READABLE_SECTION_NAME,
    render,
    scan_f,
    scan_d,
    script_dir,
)
from pprint import pprint


def readme_build(
    readme_templates_path: str, readme_default_templates_path: str, view: VIEW
) -> str:
    readmes_list = scan_f(readme_templates_path, ".md")
    readmes_defaults = scan_f(readme_default_templates_path, ".md")
    readmes_defaults = [x for x in readmes_defaults if x not in readmes_list]

    def read_files(rdm: list[str], rdm_dft: list[str]) -> VIEW:
        reademes = {}
        for i in rdm:
            path = readme_templates_path + "/" + i + ".md"
            with open(path, "r", encoding="utf-8") as f:
                reademes[i] = f.read()
        for i in rdm_dft:
            path = readme_default_templates_path + "/" + i + ".md"
            with open(path, "r", encoding="utf-8") as f:
                reademes[i] = f.read()
        return reademes

    readmes = read_files(readmes_list, readmes_defaults)
    readme = readmes["README"]
    readmes = {k: render(v, view) for k, v in readmes.items()}
    readme = render(readme, {READABLE_SECTION_NAME: readmes}, default="").rstrip("\n")

    return readme


def MKreadme(
    pkg: list[str] | bool,
    pkg_path: str | None = None,
    output_path: str | None = None,
):
    if isinstance(pkg, bool):
        pkg = scan_d(PKG_ROOT)
    pkg_path = pkg_path or PKG_ROOT
    output_path = output_path or PKG_ROOT
    readme_default_templates_path = README_DEFAULT_TEMPLATES_PATH

    for _pkg in pkg:
        _pkg_path = pkg_path + "/" + _pkg
        _tpl_path = _pkg_path + TPL_CONFIG_PATH
        _out_path = output_path + "/" + _pkg + "/README.md"
        _readme_path = _tpl_path
        pkg_meta_view = PORT(_pkg_path, _tpl_path).meta
        content = readme_build(
            _readme_path, readme_default_templates_path, pkg_meta_view
        )
        # with open(_out_path, "w", encoding="utf-8") as f:
        #     f.write(content)
