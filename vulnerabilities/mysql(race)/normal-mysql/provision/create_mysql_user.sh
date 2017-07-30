#!/bin/bash

mysql -uroot <<MYSQL_SCRIPT
CREATE DATABASE normal;
CREATE USER 'vagrant'@'localhost' IDENTIFIED BY 'vagrant';
GRANT ALL PRIVILEGES ON normal.* TO 'vagrant'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT