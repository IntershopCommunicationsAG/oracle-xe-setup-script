#!/bin/sh

source /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh

sqlplus -s /nolog <<EOF
-- restart database
connect sys/intershop as sysdba
 
shutdown immediate
startup
quit
EOF
