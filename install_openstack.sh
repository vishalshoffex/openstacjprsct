#Shell Script for openstack installation

yum install -y https://rdoproject.org/repos/rdo-release.rpm # Setup RDO repositories

yum -y install openstack-packstack #install packstack installer

sed -e "s/^  $floating_range            = .*$/  $floating_range            = '192.168.1.192\/27',/g" -i /usr/lib/python2.7/site-packages/packstack/puppet/modules/openstack/manifests/provision.pp

setenforce 0

yum -y install mariadb-server

rm -f /usr/lib/systemd/system/mysqld.service

cp /usr/lib/systemd/system/mariadb.service /usr/lib/systemd/system/mysqld.service


touch /var/log/mysqld.log

chown mysql:mysql /var/log/mysqld.log

systemctl stop sshd

packstack --allinone #Running packstack to install openstack

systemctl start sshd

ssh-keygen -t rsa


