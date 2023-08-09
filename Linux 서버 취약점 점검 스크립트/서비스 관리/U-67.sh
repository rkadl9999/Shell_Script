#!/bin/bash
. ../function.sh

BAR
CODE [U-67] SNMP 서비스 커뮤니티 스트링의 복잡성 설정
cat << EOF >> $RESULT
[ 양호 ] : SNMP Community 이름이 public, private 가 아닌 경우
[ 취약 ] : SNMP Community 이름이 public, private 인 경우
EOF
BAR

SERVICE=snmpd
STATUS=$(CheckStatus $SERVICE)

if [ -z "$STATUS" ]; then
	OK SNMP 서비스를 사용하지 않습니다.
else
	INFO SNMP 서비스를 사용하고 있습니다.
	
	CHECK=`cat /etc/snmp/snmpd.conf | grep ^com2sec | awk '{print $4}'`
	if [ "$CHECK" = "public" ] || [ "$CHECK" = "private" ]; then
		WARN SNMP Community 이름이 public 이거나 private로 설정되어 있습니다.
	else
		OK SNMP Coummunity 이름이 public, private가 아닙니다.
	fi
fi

cat $RESULT
echo; echo
