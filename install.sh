#!/bin/sh

PROG=$0
REALPATH=$(readlink -f "$PROG")
BASEDIR=$(dirname $REALPATH)

if [ $# -eq 0 ]
then
	echo "Please specify the path for the rpm"
	exit 1
fi

rpm -ivh $1

su - root -c "/etc/init.d/oracle-xe configure responseFile=$BASEDIR/xe.rsp"

source /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh
sqlplus -s system/intershop <<< "EXEC DBMS_XDB.SETLISTENERLOCALACCESS(FALSE);"

sh $BASEDIR/prepare_db.sh
sh $BASEDIR/prepare_tablespaces.sh
sh $BASEDIR/restart_db.sh
