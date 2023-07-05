#!/bin/bash
. ../function.sh

BAR
CODE [U-55] hosts.lpd 파일 소유자 및 권한 설정
cat << EOF >> $RESULT
[ 양호 ] : 파일의 소유자가 root 이고, Other에 쓰기 권한이 부여되어 있지 않은 경우
[ 취약 ] : 파일의 소유자가 root가 아니고 Other에 쓰기 권한이 부여되어 있는 경우
EOF
BAR

CHECKFILE=/etc/hosts.lpd
OWNER=$(CheckOwner $CHECKFILE 2> /dev/null)
PERM=$(CheckPerm $CHECKFILE 2> /dev/null)

if [ "$OWNER" == "root" ] ; then
if [ $PERM -eq 600 ] ; then
OK "파일의 소유자가 root 이고, 권한이 $PERM 으로 설정되어 있습니다."
else
WARN "파일의 소유자가 root로 설정되어 있지만, 권한이 600이 아닙니다."
fi
else
WARN "파일의 소유자가 root가 아닙니다."
fi

cat $RESULT
echo; echo
