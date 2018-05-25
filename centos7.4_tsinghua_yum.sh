#!/bin/bash
# local yum.repo
rpm -aq | grep yum|xargs rpm -e --nodeps
mkdir /etc/backup
mv /etc/yum.repos.d/* /etc/backup/
cd /etc/yum.repos.d/
wget http://10.10.103.101/yum_data/centos/7/os/x86_64/Packages/python-iniparse-0.4-9.el7.noarch.rpm
wget http://10.10.103.101/yum_data/centos/7/os/x86_64/Packages/python-urlgrabber-3.10-8.el7.noarch.rpm
wget http://10.10.103.101/yum_data/centos/7/os/x86_64/Packages/yum-3.4.3-158.el7.centos.noarch.rpm
wget http://10.10.103.101/yum_data/centos/7/os/x86_64/Packages/yum-metadata-parser-1.1.4-10.el7.x86_64.rpm
wget http://10.10.103.101/yum_data/centos/7/os/x86_64/Packages/yum-plugin-fastestmirror-1.1.31-45.el7.noarch.rpm
rpm -e python-urlgrabber* --nodeps
rpm -ivh python-iniparse-0.4-9.el7.noarch.rpm
rpm -ivh python-urlgrabber-3.10-8.el7.noarch.rpm
rpm -ivh yum-metadata-parser-1.1.4-10.el7.x86_64.rpm
rpm -ivh yum-3.4.3-158.el7.centos.noarch.rpm yum-plugin-fastestmirror-1.1.31-45.el7.noarch.rpm
cat >>/etc/yum.repos.d/yum.repo<<eof
[localyum]
name=centos7
baseurl=http://10.10.103.101/yum_data/centos/7/os/x86_64/
enable=1
gpgcheck=0
[localepel]
name=epel
baseurl=http://dl.fedoraproject.org/pub/epel/7/x86_64/
enable=1
gpgcheck=0
[localextra]
name=extra
baseurl=http://10.10.103.101/yum_data/centos/7/extras/x86_64/
enable=1
gpgcheck=0
eof
yum clean all
yum makecache
