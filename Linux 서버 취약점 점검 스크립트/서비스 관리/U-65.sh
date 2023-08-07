#!/bin/bash
. ../function.sh

BAR
CODE [U-65] at 파일 소유자 및 권한 설정
cat << EOF >> $RESULT
[ 양호 ] : at 접근 제어 파일의 소유자가 root이고, 권한이 640 이하인 경우
[ 취약 ] : at 접근 제어 파일의 소유자가 root가 아니거나, 권한이 640 이하가 아닌 경우
EOF
BAR

FILE=("/etc/at.deny" "/etc/at.allow")

CHECK=0

for f in "${FILE[@]}";
do
	OWNER=$(CheckOwner $f)
	PERM=$(CheckPerm $f)
	
	if [ "$OWNER" = "root" ]; then
		((CHECK++))
	fi
	
	if [ $PERM -le 640 ]; then
		((CHECK++))
	fi
done

if [ $CHECK -eq 4 ]; then
	OK 파일의 소유자가 root이고, 권한이 640 이하인 경우입니다.
else
	WARN 파일의 소유자가 root가 아니거나, 권한이 640 이하가 아닌 경우입니다.
fi

cat $RESULT
echo; echo
