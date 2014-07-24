#!/bin/bash
# copyfiles.sh
# > parameterized v. of copystuff2.sh - dja@rtk
# > uses *NIX cp conventions:
# >> source (copy-from) path is 1st input parm
# >> target (copy-to) path is 2nd parm
# > also:
# >> sets default script directory as user $HOME/src/bash/ in 3rd input parm 
# >> makes use of 3-finger claw fxns (app OS robust)

yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "cannot $*"; }

src_path="$1"
dst_path="$2"
sh_dir=${3:-$HOME"/src/bash/"}

try cp -R "$src_path" "$dst_path"
try "$sh_dir"copyattribs.sh "$src_path" "$dst_path"

