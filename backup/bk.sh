#/bin/bash
#
backup(){
  now=$(date +%Y%m%d)
  bkdir=backup/$now
  secret=$1

  mkdir -p $bkdir

  echo Backup sendo feito $(date '+%d/%m/%y - %H:%M:%S')
  #echo Mysql senha requerida...
  cp -r /var/www/html $bkdir
  cp -r /etc/asterisk $bkdir
  mysqldump -u root -p=$secret asterisk > $bkdir/asterisk.sql
  mysqldump -u root -p=$secret web > $bkdir/web.sql

  tar cjf backup$now.tar.bz2 $bkdir
}


if [ -z "$1" ]
then
  echo Forneça a senha junto ao comando. 
  echo "./bk.sh <password>"
  exit 2
fi

backup
