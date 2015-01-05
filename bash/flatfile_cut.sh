#!/bin/bash

##############################################################################
#
# flatfile_cut.sh
#
# flatfile_cut [/path/to/target/dir] file_extension fields_to_extract \
#     [delim] [out_file]
#
# EXAMPLE USAGE:
#  $ flatfile_cut.sh /path/to/dir .psv '1,3-5,10' '|' cut_dat.out
#  $ flatfile_cut.sh /path/to/dir .zip '1' ',' cut_dat.out
#
#  ! NOTE ! : Current implementation assumes a header in the flat file
#             >> change/remove `sed "1 d"` phrase if no headers
#
# ENV OPTIONS:
#  VERBOSE - default is unset, any nonzero value sets verbose output, e.g:
#    $ VERBOSE=1 flatfile_cut /path/to/dir
#
# TODO: Add checker on user parm _fields_str_, that its separator == _delim_
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
delim=${4:-","}
out_file=$5  # optional

if [ ${#field_str} > 3 && $field_str != *','* && $field_str == *${delim}* ] ; then
  yell "Use the correct file delimiter in your cut fields parameter."
  exit
fi

if [ -n "$VERBOSE" ] ; then
  yell "----------------------------------------------"
  yell "Data directory : "$data_dir  
  yell "Find files with extension : "$file_ext  
  yell "Cut in fields : "$fields_str
  yell "----------------------------------------------"
fi

case $file_ext in
  ".zip" )
    file_list=(`find ${data_dir} -type f -name '*.zip' -print`);;
  ".gzip" )
    file_list=(`find ${data_dir} -type f -name '*.gz' -print`);;
  ".bz" )
    file_list=(`find ${data_dir} -type f -name '*.bz' -print`);;
  ".csv" )
    file_list=(`find ${data_dir} -type f -name '*.csv' -print`);;
  ".psv" )
    file_list=(`find ${data_dir} -type f -name '*.psv' -print`);;
  ".tsv" )
    file_list=(`find ${data_dir} -type f -name '*.tsv' -print`);;
esac

[ -n "$VERBOSE" ] && yell "Number of files: "${#file_list[@]} 

if [ ${#file_list[@]} -gt 0 ] ; then
  for f in ${file_list[@]} ; do
    file_name=(`basename ${f%%.*} $file_ext`)
    [ -n "$VERBOSE" ] && yell $file_name
    case $file_ext in
      ".zip" )
        try unzip -p $f | sed "1 d" | cut -d ${delim} -f ${fields_str} | sed 's/^/'${file_name}',/' > ${data_dir}/${file_name}.out ;; 
      ".gz" )
        try gzcat $f | sed "1 d" | cut -d ${delim} -f ${fields_str} | sed 's/^/'${file_name}',/' > ${data_dir}/${file_name}.out ;; 
      ".bz" )
        try bzcat $f | sed "1 d" | cut -d ${delim} -f${fields_str} | sed 's/^/'${file_name}',/' > ${data_dir}/${file_name}.out ;; 
      ".csv" )
        try cat $f | sed "1 d" | cut -d "," -f${fields_str} | sed 's/^/'${file_name}',/' > ${data_dir}/${file_name}.out ;;
      ".psv" )
        try cat $f | sed "1 d" | cut -d "|" -f${fields_str} | sed 's/^/'${file_name}',/' > ${data_dir}/${file_name}.out ;;
      ".tsv" )
        try cat $f | sed "1 d" | cut -d "\t" -f${fields_str} | sed 's/^/'${file_name}',/' > ${data_dir}/${file_name}.out ;;
    esac
    if [ ${5} ] ; then
      cat "${data_dir}/${file_name}.out" >> ${5}
    fi
  done
else
  [ -n "$VERBOSE" ] && yell "No $file_ext files in input directory."
fi

true
