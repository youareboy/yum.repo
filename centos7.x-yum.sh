#!/bin/bash
rpm -aq | grep yum|xargs rpm -e --nodeps
mkdir /etc/backup
mv /etc/yum.repos.d/* /etc/backup/
cd /ertc/yum.repos.d/
wget http://mirror.centos.org/centos/7.4.1708/os/x86_64/Packages/python-iniparse-0.4-9.el7.noarch.rpm
wget http://mirror.centos.org/centos/7.4.1708/os/x86_64/Packages/python-urlgrabber-3.10-8.el7.noarch.rpm
wget http://mirror.centos.org/centos/7.4.1708/os/x86_64/Packages/yum-3.4.3-154.el7.centos.noarch.rpm
wget http://mirror.centos.org/centos/7.4.1708/os/x86_64/Packages/yum-metadata-parser-1.1.4-10.el7.x86_64.rpm
wget http://mirror.centos.org/centos/7.4.1708/os/x86_64/Packages/yum-plugin-fastestmirror-1.1.31-42.el7.noarch.rpm
rpm -ivh python-iniparse-0.4-9.el7.noarch.rpm
rpm -e python-urlgrabber-3.10-8.el7.noarch --nodeps
rpm -ivh python-urlgrabber-3.10-8.el7.noarch.rpm
rpm -ivh yum-metadata-parser-1.1.4-10.el7.x86_64.rpm
rpm -ivh yum-3.4.3-154.el7.centos.noarch.rpm yum-plugin-fastestmirror-1.1.31-42.el7.noarch.rpm
cat >>/etc/yum.repos.d/yum.repo <<eof
[localyum]
name=centos6
baseurl=http://mirror.centos.org/centos/7.4.1708/os/x86_64/
enable=1
gpgcheck=0
[localepel]
name=epel
baseurl=http://dl.fedoraproject.org/pub/epel/7/x86_64/
enable=1
gpgcheck=0
[localextra]
name=extra
baseurl=http://mirror.centos.org/centos/7.4.1708/extras/x86_64/
enable=1
gpgcheck=0
eof
yum clean all
yum makecache
