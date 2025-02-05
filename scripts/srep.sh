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
var_mode=""
var_in=""
var_out=""
var_view=""
var_inType=""
var_pattern=""

help() {
  echo "Usage $script <command> [options] [path]..."
  echo "Options:"
  echo "  -h, --help                       Show this help message"
  echo "  -v, --verbose                    Verbose"
  echo "  -T<type>                         InputType(CONV|RPSE)"
  echo "  -P<pattern>                      (REPL|PRSE)"
  echo "                                   default s/{{\${key}}}/\${value}/g"
  echo "Commands:"
  echo "  replace <in> <out> <view>        (set REPL)"
  echo "  convert <in> <out>               (set CONV)"
  echo "  parse   <in> <out>               (set PRSE)"
  echo "Examples:"
}
[ $# = 0 ] && help && exit 0

#参数提取
ARGS=$(getopt -o hvT:P: -l help,verbose,toolsPath -n "$0" -- "$@")
[ $? = 0 ] || err "Error parsing arguments"
eval set -- "$ARGS"

while true; do
  case "$1" in
  -h | --help) flag_help=true && shift ;;
  -v | --verbose) flag_verbose=true && shift ;;
  -T) var_inType=$2 && shift 2 ;;
  -P) var_pattern=$2 && shift 2 ;;
  --) shift && break ;;
  *) err "unknown option $1" ;;
  esac
done

[ $flag_help = true ] && help && exit 1

case "$1" in
replace) var_mode=REPL ;;
convert) var_mode=CONV ;;
parse) var_mode=PRSE ;;
*) err "'$1' is not a $script command." ;;
esac
shift

case "$var_mode" in
REPL)
  var_in=$1
  var_out=$2
  var_view=$3
  ;;
CONV)
  var_in=$1
  var_out=$2
  ;;
PRSE)
  var_in=$1
  var_out=$2
  ;;
*) ;;
esac

var_inType=${var_inType:-"${var_in##*.}"} #inType
case "$var_mode" in                       #pattern
REPL) var_pattern=${var_pattern:-'s/{{${key}}}/${value}/g'} ;;
PRSE)
  case "$var_inType" in
  css) var_pattern=${var_pattern:-'s/var(${key})/${value}/g'} ;;
  *) ;;
  esac
  ;;
*) ;;
esac

[[ "$var_mode" =~ ^("REPL"|"CONV"|"PRSE")$ ]] && { [ -f "$var_in" ] || err "missing input file operand after $var_in"; }
[[ "$var_mode" =~ ^("REPL"|"CONV"|"PRSE")$ ]] && { [ -n "$var_out" ] || err "missing input file operand after $var_out"; }
[[ "$var_mode" = "REPL" ]] && { [[ -f "$var_view" ]] || err "missing view file operand after $var_view"; }

repl() {
  local in=$1
  local out=$2
  local view=$3
  local pattern=$4
  touch "$out" || exit 1
  cat "$in" | "$script_dir/v_rep.sh" "$(cat "$view")" "$pattern" | tee "$out" >/dev/null
}

conv() {
  local in=$1
  local out=$2
  local inType=$3
  touch "$out" || exit 1
  [[ "$inType" = ini ]] && inType=conf
  cat "$in" | "$script_dir/cnv_$inType.sh" | tee "$out" >/dev/null
}

prse() {
  local in=$1
  local out=$2
  local pattern=$3
  local inType=$4
  touch "$out" || exit 1
  [[ "$inType" = ini ]] && inType=conf
  view=$(cat "$in" | "$script_dir/cnv_$inType.sh")
  cat "$in" | "$script_dir/v_rep.sh" "$view" "$pattern" | tee "$out" >/dev/null
}

if [ $flag_verbose = true ]; then
  echo "$script :"
  info "mode    " " $var_mode"
  case "$var_mode" in
  REPL)
    info "input   " " $var_in"
    info "output  " " $var_out"
    info "view    " " $var_view"
    info "pattern " " $var_pattern"
    ;;
  CONV)
    info "input   " " $var_in"
    info "output  " " $var_out"
    info "inType  " " $var_inType"
    ;;
  PRSE)
    info "input   " " $var_in"
    info "output  " " $var_out"
    info "pattern " " $var_pattern"
    info "inType  " " $var_inType"
    ;;
  *) ;;
  esac
fi

[[ $var_mode = REPL ]] && repl "$var_in" "$var_out" "$var_view" "$var_pattern" && exit 0
[[ $var_mode = CONV ]] && conv "$var_in" "$var_out" "$var_inType" && exit 0
[[ $var_mode = PRSE ]] && prse "$var_in" "$var_out" "$var_pattern" "$var_inType" && exit 0
err "unknown"
