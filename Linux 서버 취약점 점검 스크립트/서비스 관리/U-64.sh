#!/bin/bash
. ../function.sh

BAR
CODE [U-64] ftpusers 파일 설정
cat << EOF >> $RESULT
[ 양호 ] : FTP 서비스가 비활성화 되어 있거나, 활성화 시 root 계정 접속을 차단한 경우
[ 취약 ] : FTP 서비스가 활성화 되어 있고, root 계정 접속을 허용한 경우
EOF
BAR

SERVICE=vsftpd
STATUS=$(CheckStatus $SERVICE)

if [ -z "$STATUS" ]; then
        OK FTP 서비스를 사용하지 않습니다.
else
        INFO FTP 서비스를 사용하고 있습니다.
	CHECK=`cat /etc/vsftpd/user_list | grep ^root; cat /etc/vsftpd/ftpusers | grep ^root`
	if [ -z "$CHECK" ]; then
		OK root 계정 접속을 차단한 경우입니다.
	else
		WARN root 계정 접속을 허용한 경우입니다.
	fi
fi

cat $RESULT
echo; echo
