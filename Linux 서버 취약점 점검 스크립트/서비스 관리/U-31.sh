#!/bin/bash
. ../function.sh

BAR
CODE [U-31] 스팸 메일 릴레이 제한
cat << EOF >> $RESULT
[ 양호 ] : SMTP 서비스를 사용하지 않거나 릴레이 제한이 설정되어 있는 경우
[ 취약 ] : SMTP 서비스를 사용하며 릴레이 제한이 설정되어 있지 않은 경우
EOF
BAR

STATUS=`ps -ef | grep sendmail | grep -v grep`

if [ -z "$STATUS" ]; then
	OK SMTP 서비스를 사용하지 않습니다.
else
	RELAY=`cat /etc/mail/sendmail.cf | grep "R$₩*" | grep "Relaying denied" | awk '{print $1}'`
	if [ $RELAY == 'R$*' ]; then
		OK SMTP 릴레이 제한이 설정되어 있습니다.
	else
		WARN SMTP 릴레이 제한이 설정되어 있지 않습니다.
		INFO /etc/mail/sendmail.cf 파일의 주석 제거 후, /etc/mail/access 파일에 지정해주세요.
	fi
fi

cat $RESULT
echo; echo
