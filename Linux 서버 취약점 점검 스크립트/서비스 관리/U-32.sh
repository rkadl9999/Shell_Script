#!/bin/bash
. ../function.sh

BAR
CODE [U-32] 일반 사용자의 Sendmail 실행 방지
cat << EOF >> $RESULT
[ 양호 ] : SMTP 서비스 미사용 또는 일반 사용자의 Sendmail 실행 방지가 설정된 경우
[ 취약 ] : SMTP 서비스 사용 및 일반 사용자의 Sendmail 실행 방지가 설정되어 있지 않은 경우
EOF
BAR

STATUS=`ps -ef | grep sendmail | grep -v grep`

if [ -z "$STATUS" ]; then
	OK Sendmail 서비스가 비활성화 되어 있습니다.
else
	INFO Sendmail 서비스가 활성화 되어 있습니다.
	CHECK=`grep -v '^ *#' /etc/mail/sendmail.cf | grep PrivacyOptions | awk -F= '{print $2}' | grep restrictqrun`
	if [ -z "$CHECK" ]; then
		WARN 일반 사용자의 Sendmail 실행 방지가 설정되어 있지 않습니다.
	else
		OK 일반 사용자의 Sendmail 실행 방지가 설정되어 있습니다.
	fi
fi

cat $RESULT
echo; echo
