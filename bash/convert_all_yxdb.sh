#!/bin/bash
###########################################################
#
# convert_all_yxdb.sh
#
#  > wrapper for mburge's yxdb2csv.hs app 
#  > >> compresses input file and stdout via gzip
#
#  > usage : convert_all_yxdb.sh <source> <target> [<email>]
#  >		where <source> is the relative or full path
#  >		of the file to convert
#  >		and <target> is the path to write to
#  > example : convert_files.sh in_dir/ out_dir/
#  > example : convert_files.sh . . me@company.com
#  > NOTE : as currently scripted will overwrite existing
#  >		file of same name in target directory
##
# @cgutierrez 
#
##########################################################

yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "cannot $*"; }

ARGS=2
E_BADARGS=65
EMSG=" Input source & target directories, including full path if needed. "	

if [ $# -lt "$ARGS" ]; then
  yell "Usage: `basename $0` <source> <target> "
  die $E_BADARGS
fi

sourced="$1"
targetd="$2"
mail_to="${3:-${USER}@rentrakmail.com}"

fext=".yxdb"
file_list=(`find "$sourced" -type f -name "*$fext"`);

if [ -d "$sourced" ] && [ -d "$targetd" ]; then 
  yell "Directories to convert (from-to) : "${sourced}"*"${fext}" ==> "${targetd}"*.psv.gz"
  yell "Send to (notify) : "${mail_to}
  yell "Files of type $fext : "$'\n'${file_list[@]}
  
  if [ "$targetd" == "." ]; then
    targetd=$targetd"/"
  fi

  for f in ${file_list[@]}
  do
    tfname=$(basename "$f")
    tfname="${tfname%.*}"
    #yell "$tfname"  # DEBUG
    # https://github.com/MichaelBurge/yxdb-utils
    try ~/bin/hs/yxdb2csv "${f}" | gzip -f > "${targetd}""${tfname}".psv.gz
    try gzip -f "${f}"
  done
  try echo '' | mail -s 'File conversion from yxdb format to flat format - DONE' "$mail_to"
else
  yell "$EMSG"
  yell "Usage: `basename $0` <source> <target> "
fi

true
