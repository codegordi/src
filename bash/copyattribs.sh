# this program copies the datestamps and permissions from files in one directory to the exact same files in another directory,
# and automatically recurses down to files in subdirectories of the two directories.
# The files must have the same name and path relative to each of the two top directories.
# Run this program as root for best results.
# to get to root, type "su -" prior to running this script
# example of use: "bash copyattribs.sh /shares/usb1-1share1 /shares/Public/dja_drive" copies all attributes and datestamps
#    from each file on usb1-1share1 (and all its subdirectories) to the corresponding file on dja_drive
# This file as currently constructed gives a preview of the commands that will be issued.  To turn off preview mode and
#   actually execute the commands, change "myecho=echo" below to "myecho="
# Program by enzotib from askubuntu.com "http://askubuntu.com/questions/56792/how-to-copy-only-file-attributes-metadata-without-actual-content-of-the-file"

#!/bin/bash
# Filename: cp-metadata

myecho=echo
src_path="$1"
dst_path="$2"

find "$src_path" |
  while read src_file; do
    dst_file="$dst_path${src_file#$src_path}"
    $myecho chmod --reference="$src_file" "$dst_file"
    $myecho chown --reference="$src_file" "$dst_file"
    $myecho touch --reference="$src_file" "$dst_file"
  done
