#!/bin/bash

info() {
  local title=$1
  local info=$2
  local color=$3
  color=${color:-4} #blue

  echo \
    "$(tput setab $color setaf 0)$title$(tput sgr0)" \
    "$info"
  return 0
}

script=$(basename $0)
tip() {
  echo "Try '$script --help' for more information."
}

err() {
  local msg=$1
  local relese=$2
  relese=${relese:-tip}

  info "Error" "$script: $msg" 1
  [ -z "$relese" ] || $relese
  exit 1
}

warn() {
  local msg=$1
  info "Warning" "$script: $msg" 3
  return 0
}

#############################################################

#params
script_path=$(realpath "$0")
script_dir=$(dirname "$script_path")
flag_help=false
flag_verbose=false
flag_build=false
var_mode="ALL"
var_pkg="ALL"
var_plt="ALL"

var_pltPath=""
var_pltMetaPath=""
var_pkgPath=""
var_toolPath=""
var_viewPath=""
var_buildPath=""
flag_extend=false
flag_convert=false

act_build_pkg=false
act_build_plt=false

help() {
  echo "Usage $script <command> [options]"
  echo "Options:"
  echo "  -h, --help                  Show this help message"
  echo "  -v, --verbose               Verbose"
  echo "  -B                          Build(mode=[ALL|PKG|PLT])"
  echo "  -P<palette>                 set specific palette(ALL|specific)"
  echo "  --pltPath<path>             set palettes path"
  echo "  --pltMetaPath<Path>         set palette Meta path"
  echo "  --pkgPath<path>             set packages path"
  echo "  --toolPath<path>            set tool path"
  echo "  --viewPath<Path>            set views path"
  echo "  --buildPath<path>           set build path"
  echo "  --extend                    Extend Css(mode=PLT)"
  echo "  --convert                   Convert Css to INI(mode=PLT)"
  echo "Commands:"
  echo "  <package>                   PKG mode"
  echo "  all                         ALL mode"
  echo "  package                     PKG mode"
  echo "  palette                     PLT mode"
  echo "Examples:"
}
[ $# = 0 ] && help && exit 0

#参数提取
ARGS=$(
  getopt -o hvBP: -l \
    help,verbose,pltPath,pltMetaPath,pkgPath,toolPath,viewPath,buildPath,extend,convert \
    -n "$0" -- "$@"
)
[ $? = 0 ] || err "Error parsing arguments"
eval set -- "$ARGS"

while true; do
  case "$1" in
  -h | --help) flag_help=true && shift ;;
  -v | --verbose) flag_verbose=true && shift ;;
  -B) flag_build=true && shift ;;
  -P) var_plt=$2 && shift 2 ;;
  --pltPath) var_pltPath=$2 && shift 2 ;;
  --pltMetaPath) var_pltMetaPath=$2 && shift 2 ;;
  --pkgPath) var_pkgPath=$2 && shift 2 ;;
  --toolPath) var_toolPath=$2 && shift 2 ;;
  --viewPath) var_viewPath=$2 && shift 2 ;;
  --buildPath) var_buildPath=$2 && shift 2 ;;
  --extend) flag_extend=true && shift ;;
  --convert) flag_convert=true && shift ;;
  --) shift && break ;;
  *) err "unknown option $1" ;;
  esac
done

case "$1" in
all | "") var_mode=ALL ;;
package) var_mode=PKG && var_pkg=ALL ;;
palette) var_mode=PLT ;;
*) var_mode=PKG && var_pkg=$1 ;;
esac

var_pltPath=${var_pltPath:-"$script_dir/../palettes"}
var_pltMetaPath=${var_pltMetaPath:-"$script_dir/pltmeta"}
var_pkgPath=${var_pkgPath:-"$script_dir/../themes"}
var_toolPath=${var_toolPath:-"$script_dir"}
var_viewPath=${var_viewPath:-"$script_dir/_build"}
var_buildPath=${var_buildPath:-"$script_dir/_build"}

[ $var_mode != PLT ] &&
  flag_extend=false &&
  flag_convert=false

if [ $flag_build = true ]; then
  case "$var_mode" in
  ALL)
    act_build_pkg=true
    act_build_plt=true
    ;;
  PKG) act_build_pkg=true ;;
  PLT) act_build_plt=true ;;
  esac
fi

[[ $var_mode = PLT && ! $var_plt = ALL && ! -e "$var_pltPath/${var_plt}.css" ]] &&
  err "not found palette '$var_plt'"
if [ $var_plt = "ALL" ]; then
  unset var_plt[0]
  for i in $(find "$var_pltPath" -type f -name "*.css"); do
    var_plt+=($(basename "$i" .css))
  done
fi

[[ $var_mode = PKG && ! $var_pkg = ALL && ! -e "$var_pkgPath/$var_pkg" ]] &&
  err "not found package '$var_pkg'"
if [ $var_pkg = "ALL" ]; then
  unset var_pkg[0]
  for i in $(find "$var_pkgPath" -mindepth 1 -maxdepth 1 -type d); do
    var_pkg+=($(basename "$i" .css))
  done
fi

# echo $var_mode ${var_plt[@]} ${var_pkg[@]}

css_extend() {
  local pltPath=$var_pltPath
  local viewPath=$var_viewPath
  [ ! -d "$pltPath" ] && err "'$pltPath' not a valid directory" && return 1
  [ ! -d "$viewPath" ] && err "'$viewPath' not a valid directory" && return 1

  pltPath=$(realpath $pltPath)
  viewPath=$(realpath $viewPath)

  for plt in "${var_plt[@]}"; do
    local v="$viewPath/${plt}.css"
    local p=$pltPath/${plt}.css
    cat "$p" | sed -E 's/(--[^:]+): var\((--[^)]+)\);/\1: var(\2);\n    \1-s: var(\2-s);/' >"$v"
  done
}

css_convert() {
  local viewPath=$var_viewPath
  [ -d "$viewPath" ] || err "'$viewPath' not a valid directory"
  viewPath=$(realpath $viewPath)

  for plt in "${var_plt[@]}"; do
    local v="$viewPath/${plt}.css"
    [[ ! -f "$v" ]] && warn "not found palette file '${plt}.css'" && return 1
    local view=${viewPath}/${plt}.css.ini
    local meta=${var_pltMetaPath}/${plt}.ini
    local tool=$var_toolPath/srep.sh
    touch "$view" || exit 1
    "$tool" parse "$v" "$v"
    "$tool" convert "$v" "$view"
    "$tool" replace "$view" "$view" "$script_dir/format.ini" -P 's/${key}/${value}/g'
    [[ -e "$meta" ]] && cat "$meta" | "$var_toolPath/cnv_conf.sh" >>"$view"
  done
}

pkg_build() {
  local pkgPath=$var_pkgPath
  local viewPath=$var_viewPath
  local start="/.template/template.conf"
  for pkg in "${var_pkg[@]}"; do
    local p=$(realpath $pkgPath/$pkg)
    local P=$p/$start
    [[ $flag_verbose = true ]] && echo "build: $p"
    [[ ! -f "$P" ]] && warn "not found '$start' in package '$pkg'" && return 1

    for plt in "${var_plt[@]}"; do
      local view=${viewPath}/${plt}.css.ini
      [[ ! -f $view ]] && warn "palette '$view' is invalid" && return 1
      local conf=$(cat "$P" | "$script_dir/v_rep.sh" "$(cat $view)" 's/${${key}}/${value}/g')
      local input=$("$var_toolPath/v_find.sh" "$conf" "input")
      local output=$("$var_toolPath/v_find.sh" "$conf" "output")

      IFS='|' read -ra inputs <<<"$input"
      IFS='|' read -ra outputs <<<"$output"
      [ "${#inputs[@]}" -ne "${#outputs[@]}" ] && warn "format error ,check '$start'" && return 1
      for ((i = 0; i < ${#inputs[@]}; i++)); do
        in="$p${inputs[i]}"
        out="$p${outputs[i]}"
        # echo in: ${in}
        # echo out: ${out}
        [ ! -f "$in" ] && warn "input config is invalid,check '$start'" && return 1
        touch "$out" || (warn "output config is invalid,check '$start" && return 1)
        "$var_toolPath/srep.sh" replace "$in" "$out" "$view"
      done
    done

  done
}

# echo $act_build_spec $act_build_pkg $act_build_plt

[ $flag_extend = true ] && { css_extend && exit 0 || exit 1; }
[ $flag_convert = true ] && { css_convert && exit 0 || exit 1; }

[ $act_build_pkg = true ] && { pkg_build && exit 0 || exit 1; }
[ $act_build_plt = true ] && { css_extend && css_convert && exit 0 || exit 1; }
help && exit 1
