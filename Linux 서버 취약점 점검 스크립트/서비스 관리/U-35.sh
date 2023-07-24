#!/bin/bash
. ../function.sh

BAR
CODE [U-35] 웹 서비스 디렉토리 리스팅 제거
cat << EOF >> $RESULT
[ 양호 ] : 디렉토리 리스팅 기능을 사용하지 않는 경우
[ 취약 ] : 디렉토리 리스팅 기능을 사용하는 경우
EOF
BAR

SERVICE=httpd
STATUS=$(CheckStatus $SERVICE)

if [ -z "$STATUS" ]; then
	OK Apache 서비스를 사용하지 않습니다.
else
	INFO Apache 서비스를 사용하고 있습니다.
	CHECK=`cat /etc/httpd/conf/httpd.conf | grep "Options Indexes"`
	if [ -z "$CHECK" ]; then
		OK 디렉토리 리스팅 기능을 사용하지 않습니다.
	else
		WARN 디렉토리 리스팅 기능을 사용하고 있습니다.
	fi
fi

cat $RESULT
echo; echo
