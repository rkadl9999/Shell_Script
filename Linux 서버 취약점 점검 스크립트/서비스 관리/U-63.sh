#!/bin/bash
. ../function.sh

BAR
CODE [U-63] ftpusers 파일 소유자 및 권한 설정
cat << EOF >> $RESULT
[ 양호 ] : ftpusers 파일의 소유자가 root이고, 권한이 640 이하인 경우
[ 취약 ] : ftpusers 파일의 소유자가 root가 아니거나, 권한이 640 이하가 아닌 경우
EOF
BAR

CHECKFILE=/etc/vsftpd/ftpusers
OWNER=$(CheckOwner $CHECKFILE)
PERM=$(CheckPerm $CHECKFILE)

if [ $OWNER = 'root' ] ; then
	OK "파일의 소유자가 root 입니다."
	if [ $PERM -le 640 ] ; then
		OK "파일의 권한이 640 이하입니다."
	else
		WARN "파일의 권한이 640 이하가 아닙니다."
	fi
else
	WARN "파일의 소유자가 root가 아닙니다."
fi

cat $RESULT
echo; echo
