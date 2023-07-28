#!/bin/bash
. ../function.sh

BAR
CODE [U-39] 웹 서비스 링크 사용 금지
cat << EOF >> $RESULT
[ 양호 ] : 심볼릭 링크, aliases 사용을 제한한 경우
[ 취약 ] : 심볼릭 링크, aliases 사용을 제한하지 않은 경우
EOF
BAR

SERVICE=httpd
STATUS=$(CheckStatus $SERVICE)

if [ -z "$STATUS" ]; then
	OK Apache 서비스를 사용하지 않습니다.
else
	INFO Apache 서비스를 사용하고 있습니다.
	CHECK=`cat /etc/httpd/conf/httpd.conf | grep FollowSymLinks | grep -v "#"`
	
	if [ -z "$CHECK" ]; then
		OK 심볼릭 링크, aliases 사용을 제한한 경우입니다.
	else
		WARN 심볼릭 링크, aliases 사용을 제한하지 않은 경우입니다.
	fi
fi

cat $RESULT
echo; echo
