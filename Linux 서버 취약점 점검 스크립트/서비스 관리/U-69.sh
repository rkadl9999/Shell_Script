#!/bin/bash
. ../function.sh

BAR
CODE [U-69] NFS 설정파일 접근 제한
cat << EOF >> $RESULT
[ 양호 ] : NFS 접근제어 설정파일의 소유자가 root이고, 권한이 644 이하인 경우
[ 취약 ] : NFS 접근제어 설정파일의 소유자가 root가 아니거나, 권한이 644 이하가 아닌 경우
EOF
BAR

FILE=/etc/exports

OWNER=$(CheckOwner $FILE)
PERM=$(CheckPerm $FILE)

if [ "$OWNER" = "root" ] && [ $PERM -le 644 ]; then
	OK NFS 접근제어 설정파일의 소유자가 root이고, 권한이 644 이하인 경우입니다.
else
	WARN NFS 접근제어 설정파일의 소유자가 root가 아니거나, 권한이 644 이하가 아닌 경우입니다.
fi

cat $RESULT
echo; echo
