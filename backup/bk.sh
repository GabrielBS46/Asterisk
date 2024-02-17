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
   echo ainda em testes
  ;;
  -h | --help)
    echo './bk.sh <opcão> <arquivo>'
    echo './bk.sh -h --help    Mostra esse prompt de help'
    echo './bk.sh -i           Inicia um novo Backup do sistema e banco'
    echo './bk.sh -r <arquivo> Restabelece um backup'
    exit 0
  ;;

esac

