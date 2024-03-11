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

restaure(){
  tar xjf $1
  cd backup/`echo $1 | cut -c 7-14`
  cp -r asterisk/* /etc/asterisk/
  chown -R asterisk:asterisk /etc/asterisk
  cp -r html/* /var/www/html/
  chown -R www-data:www-data /var/www/html
  cp odbc.ini /etc/
  cp odbcinst.ini /etc/
  mysql -u root -p=$secret asterisk < asterisk.sql
  mysql -u root -p=$secret web < web.sql
  cd ../../
  rm -rf backup
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
    read -s -p "Entre com sua senha do Banco de dados: " secret
    restaure $2

  ;;
  -h | --help)
    echo './bk.sh <opcão> <arquivo>'
    echo './bk.sh -h --help    Mostra esse prompt de help'
    echo './bk.sh -i           Inicia um novo Backup do sistema e banco'
    echo './bk.sh -r <arquivo> Restabelece um backup'
    exit 0
  ;;

esac
