#!/bin/bash
. ../function.sh

BAR
CODE [U-66] SNMP 서비스 구동 점검
cat << EOF >> $RESULT
[ 양호 ] : SNMP 서비스를 사용하지 않는 경우
[ 취약 ] : SNMP 서비스를 사용하는 경우
EOF
BAR

SERVICE=snmpd
STATUS=$(CheckStatus $SERVICE)

if [ -z "$STATUS" ]; then
	OK SNMP 서비스를 사용하지 않습니다.
else
	WARN SNMP 서비스를 사용하고 있습니다.
fi

cat $RESULT
echo; echo
