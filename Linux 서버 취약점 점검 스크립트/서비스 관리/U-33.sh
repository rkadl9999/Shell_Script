#!/bin/bash
. ../function.sh

BAR
CODE [U-33] DNS 보안 버전 패치
cat << EOF >> $RESULT
[ 양호 ] : DNS 서비스를 사용하지 않거나 주기적으로 패치를 관리하고 있는 경우
[ 취약 ] : DNS 서비스를 사용하며 주기적으로 패치를 관리하고 있지 않는 경우
EOF
BAR

STATUS=`ps -ef | grep named | grep -v grep`

if [ -z "$STATUS" ]; then
	OK DNS 서비스를 사용하지 않습니다.
else
	VERSION=`named -v | awk '{print $2}' | awk -F- '{print $1}'`
	WARN DNS 서비스를 사용하고 있습니다.
	INFO 현재 사용중인 버전은 $VERSION 입니다.
	INFO https://www.isc.org/download/ 사이트에서 최신 버전을 확인해주세요.
fi

cat $RESULT
echo; echo
