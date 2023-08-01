#!/bin/bash
. ../function.sh

BAR
CODE [U-60] ssh 원격접속 허용
cat << EOF >> $RESULT
[ 양호 ] : 원격 접속 시 SSH 프로토콜을 사용하는 경우
[ 취약 ] : 원격 접속 시 Telnet, FTP 등 안전하지 않은 프로토콜을 사용하는 경우
EOF
BAR

SERVICE=sshd
STATUS=$(CheckStatus $SERVICE)

if [ -z "$STATUS" ]; then
        WARN SSH 프로토콜을 사용하지 않습니다.
else
        OK SSH 프로토콜을 사용하고 있습니다.
fi

cat $RESULT
echo; echo
