#!/bin/bash
. ../function.sh

BAR
CODE [U-36] 웹 서비스 웹 프로세스 권한 제한
cat << EOF >> $RESULT
[ 양호 ] : Apache 데몬이 root 권한으로 구동되지 않는 경우
[ 취약 ] : Apache 데몬이 root 권한으로 구동되는 경우
EOF
BAR

USER=`cat /etc/httpd/conf/httpd.conf | grep ^User | awk '{print $2}'`
GROUP=`cat /etc/httpd/conf/httpd.conf | grep ^Group | awk '{print $2}'`

TRUEFALSE=0

if [ $USER = "root" ]; then
	TRUEFALSE=1
fi
if [ $GROUP = "root" ]; then
	TRUEFALSE=1
fi

if [ $TRUEFALSE -eq 1 ]; then
	WARN Apache 데몬이 root 권한으로 구동되고 있습니다.
else
	OK Apache 데몬이 root 권한으로 구동되지 않습니다.
fi

cat $RESULT
echo; echo
