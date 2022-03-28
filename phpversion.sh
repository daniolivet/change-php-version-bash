#!/bin/bash
# This script is for switch version of php.

if [ -z "$1" ] 
then
    echo "Exec script again with a php version, Example: sh phpversion.sh php<new_version>" && exit
fi

string='php'
version=$(php -v | head -n 1 | cut -d " " -f 2 | cut -f1-2 -d".")
PHP_VERSION="${string}${version}"

# Check if $1 is the same version that system have
if [ $PHP_VERSION = $1 ]
then
    echo 'Same version' && exit
fi

# Changing version
# Disable current version
sudo a2dismod $PHP_VERSION
# Enable new version
sudo a2enmod $1
# Setting new version
sudo update-alternatives --set php /usr/bin/$1
# Reload Demon
sudo systemctl restart apache2
php -v
