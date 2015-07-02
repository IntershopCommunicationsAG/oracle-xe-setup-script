#!/bin/sh

source /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh

sqlplus -s /nolog <<EOF
-- Intershop IS_* Tablespaces
connect sys/intershop as sysdba
 
DEFINE _ts_temp     = IS_TEMP
DEFINE _ts_user     = IS_USERS
DEFINE _ts_indx     = IS_INDX
DEFINE _ts_indx_ctx = IS_INDX_CTX
DEFINE _ts_size     = 100M
DEFINE _uni_size    = 2M
DEFINE _sys_ts      = SYSTEM
 
-- Determine the file system path for the system tablespace and
-- create the Intershop tablespace files within this location.
 
COL system_ts_path NEW_VALUE path
SELECT regexp_substr(df.name, '^(.*)[\\/]') AS system_ts_path
  FROM v\$tablespace ts
  JOIN v\$datafile df ON (df.ts#=ts.ts#)
 WHERE UPPER(ts.name) = '&_sys_ts';
 
CREATE TEMPORARY TABLESPACE &_ts_temp TEMPFILE '&path.&_ts_temp._01.dbf'
  SIZE &_ts_size AUTOEXTEND ON NEXT &_ts_size MAXSIZE UNLIMITED
  EXTENT MANAGEMENT LOCAL UNIFORM SIZE &_uni_size;
 
CREATE TABLESPACE &_ts_user DATAFILE '&path.&_ts_user._01.dbf'
  SIZE &_ts_size AUTOEXTEND ON NEXT &_ts_size MAXSIZE UNLIMITED
  EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO;
 
CREATE TABLESPACE &_ts_indx DATAFILE '&path.&_ts_indx._01.dbf'
  SIZE &_ts_size AUTOEXTEND ON NEXT &_ts_size MAXSIZE UNLIMITED
  EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO;
 
CREATE TABLESPACE &_ts_indx_ctx DATAFILE '&path.&_ts_indx_ctx._01.dbf'
  SIZE &_ts_size AUTOEXTEND ON NEXT &_ts_size MAXSIZE UNLIMITED
  EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO;

quit
EOF

if [ $? -ne 0 ]
then
	exit 1
fi
