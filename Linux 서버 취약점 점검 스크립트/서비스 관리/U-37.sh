#!/bin/bash
. ../function.sh

BAR
CODE [U-37] 웹서비스 상위 디렉토리 접근 금지
cat << EOF >> $RESULT
[ 양호 ] : 상위 디렉토리에 이동 제한을 설정한 경우
[ 취약 ] : 상위 디렉토리에 이동 제한을 설정하지 않은 경우
EOF
BAR

SERVICE=httpd
STATUS=$(CheckStatus $SERVICE)

if [ -z "$STATUS" ]; then
	OK Apache 서비스를 사용하지 않습니다.
else
	INFO Apache 서비스를 사용하고 있습니다.
	CHECK=`cat /etc/httpd/conf/httpd.conf | grep AllowOverride | grep -v "#" | grep -i none`
	if [ -z "$CHECK" ]; then
		OK 상위 디렉토리에 이동 제한을 설정한 경우입니다.
	else
		WARN 상위 디렉토리에 이동 제한을 설정하지 않은 경우입니다.
	fi
fi

cat $RESULT
echo; echo
