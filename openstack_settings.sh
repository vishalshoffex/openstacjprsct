#Shell Script for all Settings

yum -y update

systemctl enable sshd
systemctl start sshd

yum -y install zfs-fuse
systemctl enable zfs-fuse
systemctl start zfs-fuse

yum -y install openvswitch

cat <<EOF >/etc/sysconfig/network-scripts/ifcfg-br-ex
DEVICE=br-ex
OVSBOOTPROTO=dhcp
OVSDHCPINTERFACES=em1
NM_CONTROLLED=no
ONBOOT=yes
TYPE=OVSBridge
DEVICETYPE=ovs
EOF

cat <<EOF >/etc/sysconfig/network-scripts/ifcfg-em1
DEVICE="em1"
HWADDR="BC:AE:C5:74:97:11"
UUID="dd86d0fb-dedf-4fd8-be7c-f99b19dbfe0d"
TYPE="OVSPort"
DEVICETYPE="ovs"
OVS_BRIDGE="br-ex"
ONBOOT="yes"
NM_CONTROLLED="no"
EOF

systemctl stop NetworkManager
systemctl disable NetworkManager

systemctl enable network

reboot
