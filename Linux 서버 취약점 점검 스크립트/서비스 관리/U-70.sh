#!/bin/bash
. ../function.sh

BAR
CODE [U-70] expn, vrfy 명령어 제한
cat << EOF >> $RESULT
[ 양호 ] : SMTP 서비스 미사용 또는, noexpn, novrfy 옵션이 설정되어 있는 경우
[ 취약 ] : SMTP 서비스를 사용하고, noexpn, novrfy 옵션이 설정되어 있지 않은 경우
EOF
BAR

SERVICE=sendmail
STATUS=$(CheckStatus $SERVICE)

if [ -z "$STATUS" ]; then
	OK SMTP 서비스를 사용하지 않습니다.
else
	INFO SMTP 서비스를 사용하고 있습니다.
	
	noexpn=`cat /etc/mail/sendmail.cf | grep PrivacyOptions | grep noexpn`
	novrfy=`cat /etc/mail/sendmail.cf | grep PrivacyOptions | grep novrfy`

	if [ -n "$noexpn" ] && [ -n "$novrfy" ]; then
		OK noexpn, novrfy 옵션이 설정되어 있습니다.
	else
		WARN noexpn. novrfy 옵션이 설정되어 있지 않습니다.
	fi
fi

cat $RESULT
echo; echo
