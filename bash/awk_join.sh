#!/bin/bash
## use awk to join files in cases where not all keys exist in all files
##
## cgutierrez

awk 'END {
  for (K in k) print K, k[K]
        }
        { 
            k[$1] = k[$1] ? k[$1] FS $2 : $2 
              }' "$1" "$2"
