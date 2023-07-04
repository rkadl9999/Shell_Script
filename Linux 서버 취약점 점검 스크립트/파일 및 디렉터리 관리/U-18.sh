#!/bin/bash
. ../function.sh

BAR
CODE [U-18] 접속 IP 및 포트 제한
cat << EOF >> $RESULT
[ 양호 ] : /etc/hosts.deny 파일에 ALL Deny 설정 후
/etc/hosts.allow 파일에 접근을 허용할 특정 호스트를 등록한 경우
[ 취약 ] : 위와 같이 설정되지 않은 경우
EOF
BAR

cat /etc/hosts.deny | grep -v '^#' | grep 'ALL:ALL' > /dev/null 2>&1

if [ $? -eq 0 ] ; then
OK "/etc/hosts.deny 파일에 ALL Deny 설정이 되어 있습니다."
else
WARN "/etc/hosts.deny 파일에 ALL Deny 설정이 되어 있지 않습니다."
INFO "/etc/hosts.deny, /etc/hosts.allow 파일 설정을 확인하세요."
fi

cat $RESULT
echo; echo
