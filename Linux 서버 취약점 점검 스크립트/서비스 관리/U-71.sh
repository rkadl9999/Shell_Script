#!/bin/bash
. ../function.sh

BAR
CODE [U-71] Apache 웹 서비스 정보 숨김
cat << EOF >> $RESULT
[ 양호 ] : ServerTokens Prod, ServerSignature Off로 설정되어 있는 경우
[ 취약 ] : ServerTokens Prod, ServerSignature Off로 설정되어 있지 않은 경우
EOF
BAR

SERVICE=httpd
STATUS=$(CheckStatus $SERVICE)

if [ -z "$STATUS" ]; then
	OK Apache 서비스를 사용하지 않습니다.
else
	INFO Apache 서비스를 사용하고 있습니다.
	CHECK1=`cat /etc/httpd/conf/httpd.conf | grep ServerSignature | grep Off`
	CHECK2=`cat /etc/httpd/conf/httpd.conf | grep ServerTokens | grep Prod`
	
	if [ -n "$CHECK1" ] && [ -n "$CHECK2" ]; then
		OK ServerTokens Prod, ServerSignature Off로 설정되어 있는 경우입니다.
	else
		WARN ServerTokens Prod, ServerSignature Off로 설정되어 있지 않은 경우입니다.
	fi
fi

cat $RESULT
echo; echo
