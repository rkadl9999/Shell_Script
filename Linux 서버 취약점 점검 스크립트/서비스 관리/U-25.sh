#!/bin/bash
. ../function.sh

BAR
CODE [U-25] NFS 접근 통제
cat << EOF >> $RESULT
[ 양호 ] : 불필요한 NFS 서비스를 사용하지 않거나, 불가피하게 사용 시 everyone 공유를 제한한 경우
[ 취약 ] : 불필요한 NFS 서비스를 사용하고 있고, everyone 공유를 제한하지 않은 경우
EOF
BAR

CHECK1=$(systemctl list-unit-files nfs-server.service | grep ^nfs | awk '{print $2}')
HOSTNAME=$(hostname)
CHECK2=$(showmount -e $HOSTNAME | grep everyone | wc -l)

if [ $CHECK1 == 'disabled' ] || [ $CHECK2 = 0 ]; then
OK 불필요한 NFS 서비스를 사용하지 않거나, 불가피하게 사용 시 everyone 공유를 제한한 경우
else
WARN 불필요한 NFS 서비스를 사용하고 있고, everyone 공유를 제한하지 않은 경우
fi

cat $RESULT
echo; echo
