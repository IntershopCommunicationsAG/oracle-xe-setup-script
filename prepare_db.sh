#!/bin/sh

source /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh

sqlplus -s /nolog <<EOF
-- Unlock the CTXSYS User
connect sys/intershop as sysdba

ALTER user ctxsys account unlock;
ALTER user ctxsys identified by ctxsys;

-- Grants with Grant Option for CTXSYS User and Lock CTXSYS Again
connect ctxsys/ctxsys;
 
GRANT EXECUTE ON CTX_DDL TO sys    WITH GRANT OPTION;
GRANT EXECUTE ON CTX_DDL TO system WITH GRANT OPTION;
 
connect sys/intershop as sysdba
 
ALTER user ctxsys account lock;

-- Increase open_cursors and processes and Disable sec_case_sensitive_logon
connect sys/intershop as sysdba
 
ALTER SYSTEM SET processes                = 180    scope = spfile;
ALTER SYSTEM SET open_cursors             = 500    scope = both;
ALTER SYSTEM SET sec_case_sensitive_logon = false  scope = both;
 
show parameter processes
show parameter open_cursors
show parameter sec_case_sensitive_logon

-- Set Default Password Security Profile Parameters to Unlimited Within 11gR2
ALTER profile DEFAULT limit FAILED_LOGIN_ATTEMPTS   UNLIMITED;
ALTER profile DEFAULT limit PASSWORD_GRACE_TIME     UNLIMITED;
ALTER profile DEFAULT limit PASSWORD_LIFE_TIME      UNLIMITED;
ALTER profile DEFAULT limit PASSWORD_LOCK_TIME      UNLIMITED;

quit
EOF

if [ $? -ne 0 ] 
then
	exit 1
fi
