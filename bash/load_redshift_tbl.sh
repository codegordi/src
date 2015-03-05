#!/bin/bash

## load_redshift_tbl.sh
## >> load file into Redshift temp table
##
## dependency : redshift_helper.sh
##

source "${HOME}/bash_lib/misc.sh"

#require_value 'AWS_CREDENTIALS'  # use helper function
aws_credentials='aws_access_key_id='${AWS_ACCESS_KEY}';aws_secret_access_key='${AWS_SECRET_KEY}  # use stored user vars

schema='temp'
table_name='example_weights'
file_name='example_weights.txt'

echo 'Loading data from file: '${file_name}
date

execute_redshift_query <<EOF
drop table if exists ${schema}.${table_name};
create table ${schema}.${table_name} (
  region_id int,
  case_id int,
  weight float8
) ;

copy ${schema}.${table_name}
from 's3://as-redshift/data-pulls/${file_name}'
  credentials '$aws_credentials'
  ignoreheader 1
  delimiter '|'
;
EOF

date


