#!/usr/bin/python
import os, sys
### Formated for Python3
### Install alembic ansible not available for python2

if os.getuid() != 0:
    print("Is not root, please user root")
    sys.exit(0)

################ WGETTTTT DO STARFISH

pkt = [
    'epel-release',
    'python-pip',
    'vim wget dnf',
    'unixODBC',
    'mysql-connector-odbc'
]
docs = [
    'pip3 install alembic ansible',
    'pip3 install --upgrade pip',
    'mkdir /etc/ansible',
    'useradd astmin',   
    'chown astmin:astmin /etc/ansible',
    'echo "[starfish]" >> /etc/ansible/hosts',
    'echo "localhost ansible_connection=local" >> /etc/ansible/hosts',
    'mkdir -p ~/ansible/playbooks'
    #'touch  ~/ansible/playbooks/starfish.yml'

]

os.system('yum -y update')

for i in pkt:
    os.system(f'yum -y install {i}')
    print(f'\033[32mFeito {i}\033[0;0m')

for j in docs:
    os.system(j)
    print(f'\033[32mFeito {j}\033[0;0m')



################ WGETTTTT DO STARFISH
'ansible-playbook /root/ansible/playbooks starfish.yml'
###echo "select 1" | isql -v asterisk asterisk password_Asterisk