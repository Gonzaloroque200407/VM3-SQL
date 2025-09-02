# Setup do BD (VM3)

## Instalação (MySQL/MariaDB)
sudo apt update
sudo apt install -y mysql-server

# Checar serviço
sudo systemctl enable --now mysql
sudo systemctl status mysql

## Criar DB e usuário de app
sudo mysql -e "
CREATE DATABASE IF NOT EXISTS gkevents CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS 'gkevents'@'172.16.120.%' IDENTIFIED WITH mysql_native_password BY 'SenhaForteAqui';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,ALTER,INDEX ON gkevents.* TO 'gkevents'@'172.16.120.%';
FLUSH PRIVILEGES;
"

## Aplicar schema
mysql -u root -p gkevents < schema/schema.mysql.sql

## Segurança/rede
# 1) Bind somente na rede interna OU em 0.0.0.0 com firewall
#    /etc/mysql/mysql.conf.d/mysqld.cnf -> bind-address = 0.0.0.0
# 2) UFW: permitir acesso ao MySQL só da VM2
sudo ufw allow from 172.16.120.129 to any port 3306 proto tcp
sudo ufw enable
