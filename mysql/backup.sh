#!/bin/bash
DIR_OUT="/var/backups/mysql"
FECHA=`date +%Y-%m-%d`

##################################
#Respaldo de BD's mysql
##################################
backup_db() {
    local PASSWD="password"
    local P="$DIR_OUT/dbs"

    local OUT_PATH="$P/$FECHA"

    mkdir -p $OUT_PATH

    local DBLIST=`mysql -e "show databases" --password=$PASSWD| egrep -v "(Database|information_schema)"`

    for DBASE in $DBLIST; do
            NFILE=$OUT_PATH/$DBASE".sql.gz"
            mysqldump -u root --password=$PASSWD -B $DBASE | gzip -9c > $NFILE
            echo $NFILE
    done
}

backup_db
