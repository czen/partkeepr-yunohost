#!/bin/bash
domain=$YNH_APP_ARG_DOMAIN
path=$YNH_APP_ARG_PATH
ynh_app_setting_set $app domain $domain

sudo apt-get update
sudo apt-get -y upgrade
# sudo apt-get -y install ntp
sudo apt-get -y install php-curl php-ldap php-bcmath php-gd php-dom

#mysql> USE mysql;
#mysql> CREATE USER 'PartKeepr'@'localhost' IDENTIFIED BY '11111'; #'insert_password_here';
#mysql> UPDATE user SET plugin='mysql_native_password' WHERE User='PartKeepr';
#mysql> FLUSH PRIVILEGES;
#mysql> CREATE DATABASE PartKeepr CHARACTER SET UTF8;
#mysql> GRANT USAGE ON *.* to 'PartKeepr'@'localhost';
#mysql> GRANT ALL PRIVILEGES ON PartKeepr.* TO 'PartKeepr'@'localhost';
#mysql> EXIT;
# The password will be stored as 'mysqlpwd' into the app settings,
# $db_pwd

service mysql restart
# only php-apcu and php-apcu-bc are new for yunohost default install on debian-stretch
sudo apt-get install php php-apcu php-apcu-bc php-curl php-gd php-intl php-ldap php-mysql php-dom php-xml

cd ~
curl -O https://downloads.partkeepr.org/partkeepr-1.4.0.tbz2
mkdir /var/www/partkeepr
sudo tar -xjvf partkeepr-1.4.0.tbz2 -C /var/www/partkeepr
cd /var/www/partkeepr 
mv partkeepr-1.4.0/* ./
rm -rf partkeepr-1.4.0
sudo chown -R root:root /var/www/partkeepr

# edit:
sudo nano /etc/php/7.0/fpm/php.ini
# max_execution_time = 120 # not 30


# permissions:
chown -R partkeepr:root /var/www/partkeepr/data
chown -R partkeepr:root /var/www/partkeepr/app
chown -R partkeepr:root /var/www/partkeepr/app/logs
chown -R partkeepr:root /var/www/partkeepr/app/cache
chown -R partkeepr:root /var/www/partkeepr/web
chmod u+w /var/www/partkeepr/app
chmod u+w /var/www/partkeepr/app/logs
chmod u+w /var/www/partkeepr/app/cache
chmod u+w /var/www/partkeepr/data
chmod u+w /var/www/partkeepr/web