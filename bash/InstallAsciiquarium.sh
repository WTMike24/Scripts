#!/bin/bash

# Uses code from https://askubuntu.com/a/927442/842032

if [[ `id -u` -ne 0 ]]; then
 echo "This script must be run as root..."
 exit 1
fi

dir=`pwd`

tput smcup

apt install libcurses-perl -y

cd /tmp
wget https://robobunny.com/projects/asciiquarium/asciiquarium.tar.gz --no-check-certificate
tar -xzf asciiquarium.tar.gz
cp asciiquarium_1.1/asciiquarium /usr/local/bin/asciiquarium
chmod 0755 /usr/local/bin/asciiquarium

cd /tmp
wget http://search.cpan.org/CPAN/authors/id/K/KB/KBAUCOM/Term-Animation-2.6.tar.gz
tar -zxf Term-Animation-2.6.tar.gz
cd Term-Animation-2.6
perl Makefile.PL &&  make &&   make test
make install

cd /tmp
rm -rf /tmp/Term-Animation-2.6.tar.gz
rm -rf /tmp/asciiquarium.tar.gz
rm -rf /tmp/Term-Animation-2.6
rm -rf /tmp/asciiquarium_1.1

cd $dir
tput rmcup
/usr/local/bin/asciiquarium
