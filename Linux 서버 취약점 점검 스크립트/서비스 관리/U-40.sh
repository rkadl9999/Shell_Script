#!/bin/bash
. ../function.sh

BAR
CODE [U-40] 웹 서비스 파일 업로드 및 다운로드 제한
cat << EOF >> $RESULT
[ 양호 ] : 파일 업로드 및 다운로드를 제한한 경우
[ 취약 ] : 파일 업로드 및 다운로드를 제한하지 않은 경우
EOF
BAR

SERVICE=httpd
STATUS=$(CheckStatus $SERVICE)

if [ -z "$STATUS" ]; then
	OK Apache 서비스를 사용하지 않습니다.
else
	INFO Apache 서비스를 사용하고 있습니다.
	CHECK=$(cat /etc/httpd/conf/httpd.conf | grep LimitRequestBody)
	
	if [ -z "$CHECK" ]; then
		WARN 파일 업로드 및 다운로드를 제한하지 않은 경우입니다.
	else
		OK 파일 업로드 및 다운로드를 제한한 경우입니다.
	fi
fi

cat $RESULT
echo; echo
