#!/bin/bash
. ../function.sh

BAR
CODE [U-47] 패스워드 최대 사용기간 설정
cat << EOF >> $RESULT
[ 양호 ] : 패스워드 최대 사용기간이 90일 (12주) 이하로 설정되어 있는 경우
[ 취약 ] : 패스워드 최대 사용기간이 90일 (12주) 이하로 설정되어 있지 않은 경우
EOF
BAR

TMP=`SCRIPTNAME`.log
> $TMP

Value=$(egrep -v '^#|^$' /etc/login.defs | grep PASS_MAX_DAYS)
CHECK_FILE=$(egrep -v '^#|^$' /etc/login.defs | grep PASS_MAX_DAYS | awk '{print $2}')

if [ $CHECK_FILE -le 90 ] ; then
OK "패스워드 최대 사용기간이 90일 (12주) 이하로 설정되어 있습니다."
else
WARN "패스워드 최대 사용기간이 90일 (12주) 이하로 설정되어 있지 않습니다."
INFO $TMP 파일을 참고하세요.
echo "=======================================================================" >> $TMP
echo "/etc/login.defs 파일의 내용입니다." >> $TMP
echo "" >> $TMP
echo $Value >> $TMP
echo "=======================================================================" >> $TMP
fi

cat $RESULT
echo; echo
