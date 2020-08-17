#!/bin/bash

cd `dirname $0`

cp sources.list /etc/apt/

apt update && apt upgrade -y
apt install -y \
	dnsutils \
	net-tools \
	open-vm-tools \
	sudo \
	vim \
	wget


cp vimrc /etc/vim/

cp bashrc /root/.bashrc
cp bashrc /home/vagrant/.bashrc
cp bashrc /etc/skel/.bashrc
sed -i 's/32m/31m/g' /root/.bashrc

cp blacklist.conf /etc/mobprob.d/
update-initramfs -u


mkdir /home/vagrant/.ssh/
wget -O /home/vagrant/.ssh/authorized_keys https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub
chown -R vagrant: /home/vagrant/.ssh/

echo "vagrant   ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/vagrant; \
chmod 0440 /etc/sudoers.d/vagrant; \


perl -p -i -e 's/(?<=iface\s).+?(?=\s)/eth0/g' /etc/network/interfaces; \
perl -p -i -e 's/eth0 inet loopback/lo inet loopback/g' /etc/network/interfaces; \
perl -p -i -e 's/(?<=hotplug\s).+?(?=\s)/eth0/g' /etc/network/interfaces

eject

apt install -y openssh-server
