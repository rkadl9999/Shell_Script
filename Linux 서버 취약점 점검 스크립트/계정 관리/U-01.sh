#!/bin/bash
. ../function.sh

BAR

CODE [U-01] root 계정 원격 접속 제한
cat << EOF >> $RESULT
[ 양호 ]: 원격 서비스를 사용하지 않거나 사용시 직접 접속을 차단한 경우
[ 취약 ]: root 직접 접속을 허용하고 원격 서비스를 사용하는 경우
EOF
BAR

TELNET_SERVICE=telnet.socket
SECURETTY=/etc/securetty
STATUS1=$(systemctl is-active $TELNET_SERVICE)

if [ $STATUS1 = 'active' ] ; then
	WARN 'Service is activated. You must Turn off the Service!'
	if [ -f $SECURETTY ] ; then
		INFO '/etc/securetty 파일이 존재합니다!'
		grep -q 'pts/' $SECURETTY # -q no output. only 0 or 1
		if [ $? -eq 0 ] ; then
			WARN '/etc/securetty 파일 안에 pts/# 존재합니다.'
		else
			OK '/etc/securetty 파일 안에 pts/# 존재하지 않습니다.'
		fi
	else
		WARN '/etc/securetty 파일이 존재하지 않습니다.'
	fi
else
	OK Remote Service is deactivated.
fi

cat $RESULT
