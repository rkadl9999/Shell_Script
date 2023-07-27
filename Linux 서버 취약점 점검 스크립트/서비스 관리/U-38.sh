#!/bin/bash
. ../function.sh

BAR
CODE [U-38] 웹 서비스 불필요한 파일 제거
cat << EOF >> $RESULT
[ 양호 ] : 기본으로 생성되는 불필요한 파일 및 디렉토리가 제거되어 있는 경우
[ 취약 ] : 기본으로 생성되는 불필요한 파일 및 디렉토리가 제거되지 않은 경우
EOF
BAR

SERVICE=httpd
STATUS=$(CheckStatus $SERVICE)

if [ -z "$STATUS" ]; then
	OK Apache 서비스를 사용하지 않습니다.
else
	INFO Apache 서비스를 사용하고 있습니다.
	CHECK=`find / -name manual 2> /dev/null`
	if [ -z "$CHECK" ]; then
		OK 불필요한 파일 및 디렉토리가 제거되어 있습니다.
	else
		WARN 불필요한 파일 및 디렉토리가 제거되지 않았습니다.
	fi
fi

cat $RESULT
echo; echo
