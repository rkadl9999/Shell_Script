#!/bin/bash
. ../function.sh

BAR
CODE [U-34] DNS Zone Transfer 설정
cat << EOF >> $RESULT
[ 양호 ] : DNS 서비스 미사용 또는, Zone Transfer를 허가된 사용자에게만 허용한 경우
[ 취약 ] : DNS 서비스를 사용하며 Zone Transfer를 모든 사용자에게 허용한 경우
EOF
BAR

STATUS=`ps -ef | grep named | grep -v grep`

if [ -z "$STATUS" ]; then
	OK DNS 서비스를 사용하지 않습니다.
else
	INFO DNS 서비스를 사용하고 있습니다.
	ALLOW_TRANSFER=`cat /etc/named.conf | grep allow-transfer`
	if [ -z "$ALLOW_TRANSFER" ]; then
		WARN Zone Transfer를 모든 사용자에게 허용하고 있습니다.
	else
		OK Zone Transfer를 허가된 사용자에게만 허용하고 있습니다.
	fi
fi

cat $RESULT
echo; echo
