#!/bin/bash
. ../function.sh

TMP=`SCRIPTNAME`.log
> $TMP

BAR
CODE [U-48] 패스워드 최소 사용기간 설정
cat << EOF >> $RESULT
[ 양호 ] : 패스워드 최소 사용기간이 7일 (1주)로 설정되어 있는 경우
[ 취약 ] : 패스워드 최소 사용기간이 설정되어 있지 않은 경우
EOF
BAR

LOGINDEFSFILE=/etc/login.defs
SEARCHVALUE=PASS_MIN_DAYS
NUM=$(SearchValue VALUE $LOGINDEFSFILE $SEARCHVALUE)
if [ $NUM -ge 7 ] ; then
OK "패스워드 최소 사용기간이 7일 (1주)로 설정되어 있습니다."
else
WARN "패스워드 최소 사용기간이 7일 (1주)로 설정되어 있지 않습니다."
INFO $TMP 파일을 참고하세요.
echo "========================================================================" >> $TMP
echo "$LOGINDEFSFILE 파일의 내용입니다." >> $TMP
echo "" >> $TMP
SearchValue KEYVALUE $LOGINDEFSFILE $SEARCHVALUE >> $TMP
echo "========================================================================" >> $TMP
fi

cat $RESULT
echo; echo
