#/bin/bash
# Script para bk

backup(){
  now=$(date +%Y%m%d)
  bkdir=backup/$now

  mkdir -p $bkdir

  printf "\nBackup sendo feito $(date '+%d/%m/%y - %H:%M:%S')\n"
  #echo Mysql senha requerida...
  cp -r /var/www/html $bkdir
  cp -r /etc/asterisk $bkdir
  cp /etc/odbc.ini $bkdir
  cp /etc/odbcinst.ini $bkdir
  mysqldump -u root -p=$secret asterisk > $bkdir/asterisk.sql
  mysqldump -u root -p=$secret web > $bkdir/web.sql

  tar cjf backup$now.tar.bz2 $bkdir
}

if [ -z "$1" ]
then
  echo Selecione a opção
  echo "./bk.sh -h para mais informações"
  exit 2
fi

case $1 in
  -i)
    read -s -p "Entre com sua senha do Banco de dados: " secret
    backup
  ;;
  -r)
    if [ -z "$2" ]
     then
       echo Informe o nome do arquivo de BK.tar.bz2
       echo "./bk.sh -r <backup.tar.bz2>"
       exit 2
     fi
    tar xjf $2
    bk=`$2 | sed 's/........$//'`
    cp -r $bk/asterisk/* /etc/asterisk/
    chown -R asterisk.asterisk /etc/asterisk
    cp -r $bk/html* /var/www/html/
    chown -R www-data.www-data /var/www/html
    mysqldump -u root -p=$secret asterisk < default/asterisk.sql
    mysqldump -u root -p=$secret web < default/asterisk.sql
    rm -rf $bk
  ;;
  -h | --help)
    echo './bk.sh <opcão> <arquivo>'
    echo './bk.sh -h --help    Mostra esse prompt de help'
    echo './bk.sh -i           Inicia um novo Backup do sistema e banco'
    echo './bk.sh -r <arquivo> Restabelece um backup'
    exit 0
  ;;

esac

