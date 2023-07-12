#!/bin/bash
. ../function.sh

BAR
CODE [U-24] NFS 서비스 비활성화
cat << EOF >> $RESULT
[ 양호 ] : 불필요한 NFS 서비스 관련 데몬이 비활성화 되어 있는 경우
[ 취약 ] : 불필요한 NFS 서비스 관련 데몬이 활성화 되어 있는 경우
EOF
BAR

ps -ef | egrep "nfs|nfsd|statd|mountd" | grep -v grep >/dev/null 2>&1 
if [ $? != 0 ] ; then
OK NFS 서비스가 비활성화 되어 있습니다.
else
WARN NFS 서비스가 활성화 되어 있습니다. 
fi

cat $RESULT
echo; echo
