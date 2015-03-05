#!/bin/bash

## redshift_helpers.sh
## bash functions to help with programmatic
##  redshift querying

function require_value () {
  name=$1
  value=${!name}
  if [ -z $value ] ; then
    echo "No $name given"
    exit 1
  fi
}

function execute_redshift_query () {
  query_file=$1
  psql \
    --no-psqlrc \
    -h $redshift_host \
    -p $redshift_port \
    -U $redshift_user \
    $redshift_database \
    $query_file
}
