#!/bin/bash

##############################################################################
#
# flatfile_cut.sh
#
# flatfile_cut [/path/to/target/dir] file_extension
#
# EXAMPLE USAGE:
#  $ flatfile_cut.sh /path/to/dir .ext
#
# ENV OPTIONS:
#  VERBOSE - default is unset, any nonzero value sets verbose output, e.g:
#    $ VERBOSE=1 flatfile_cut /path/to/dir
#
# cgutierrez@
#
##############################################################################

yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "cannot $*"; }

data_dir=${1:-$HOME"/projects"}
file_ext=${2:-".zip"}
fields_str=${3:-"1"}
out_file=$4  # optional


if [ -n "$VERBOSE" ] ; then
  yell "----------------------------------------------"
  yell "Data directory : "$data_dir  
  yell "Find files with extension : "$file_ext  
  yell "Cut in fields : "$fields_str
  yell "----------------------------------------------"
fi

case $file_ext in
  ".zip" )
    file_list=(`find $data_dir -type f -name '*.zip' -print`);;
  ".gzip" )
    file_list=(`find $data_dir -type f -name '*.gz' -print`);;
  ".bz" )
    file_list=(`find $data_dir -type f -name '*.bz' -print`);;
  ".csv" )
    file_list=(`find $data_dir -type f -name '*.csv' -print`);;
esac

[ -n "$VERBOSE" ] && yell "Number of files: "${#file_list[@]}  # DEBUG line		

if [ ${#file_list[@]} -gt 0 ] ; then
  for f in ${file_list[@]} ; do
    file_name=(`basename ${f%%.*} $file_ext`)
    [ -n "$VERBOSE" ] && yell $file_name
    case $file_ext in
      ".zip" )
        try unzip -p $f | sed "1 d" | cut -d "," -f ${fields_str} | sed 's/^/'${file_name}',/' > $data_dir/$file_name.out ;; 
      ".gz" )
        try gzcat $f | sed "1 d" | cut -d "," -f ${fields_str} | sed 's/^/'${file_name}',/' > $data_dir/$file_name.out ;; 
      ".bz" )
        try bzcat $f | sed "1 d" | cut -d "," -f${fields_str} | sed 's/^/'${file_name}',/' > $data_dir/$file_name.out ;; 
      ".csv" )
        try cat $f | sed "1 d" | cut -d "," -f${fields_str} | sed 's/^/'${file_name}',/' > $data_dir/$file_name.out ;;
    esac
    if [ $4 ] ; then
      cat "$data_dir/$file_name.out" >> $4
    fi
  done
else
  [ -n "$VERBOSE" ] && yell "No $file_ext files in input directory."
fi

true
