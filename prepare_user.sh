#!/bin/sh

if [ $# -lt 2 ]
then
        echo "Please specify username and password"
        exit 1
fi

source /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh

sqlplus -s /nolog <<EOF
-- Intershop Database User
connect sys/intershop as sysdba
 
DEFINE _us         = $1
DEFINE _pw         = $2
DEFINE _ts_temp    = IS_TEMP
DEFINE _ts_user    = IS_USERS
 
CREATE USER &_us
  IDENTIFIED BY &_pw
  DEFAULT TABLESPACE &_ts_user
  TEMPORARY TABLESPACE &_ts_temp
  PROFILE DEFAULT ACCOUNT UNLOCK;
 
ALTER USER &_us DEFAULT ROLE ALL;
 
GRANT CONNECT                       TO &_us;
GRANT RESOURCE                      TO &_us;
GRANT CTXAPP                        TO &_us;
GRANT UNLIMITED TABLESPACE          TO &_us;
GRANT CREATE CLUSTER                TO &_us;
GRANT CREATE DATABASE LINK          TO &_us;
GRANT CREATE SEQUENCE               TO &_us;
GRANT CREATE SYNONYM                TO &_us;
GRANT CREATE TABLE                  TO &_us;
GRANT CREATE VIEW                   TO &_us;
GRANT CREATE PROCEDURE              TO &_us;
GRANT CREATE TRIGGER                TO &_us;
GRANT CREATE TYPE                   TO &_us;
GRANT CREATE SNAPSHOT               TO &_us;
GRANT ANALYZE ANY                   TO &_us;
GRANT EXECUTE ON CTX_DDL            TO &_us;
GRANT EXECUTE ON DBMS_STREAMS_ADM   TO &_us;

quit
EOF
