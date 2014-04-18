#!/bin/bash
# This is a ShellScript For Auto DB Backup and Delete old Backup
#
#backupdir=/bak/mysqlbak
backupdir=.
mysqldir=/usr/local/mysql/bin/

time=` date +%Y%m%d%H `
$mysqldir/mysqldump -u root -p123456 -B --add-drop-database db1 db2 db3 | gzip > $backupdir/backup_database_$time.sql.gz
#
find $backupdir -name "backup_database_*.sql.gz" -type f -mtime +5 -exec rm {} \; > /dev/null 2>&1
