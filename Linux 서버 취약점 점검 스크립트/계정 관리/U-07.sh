#!/bin/bash
. ../function.sh

BAR
CODE [U-07] 패스워드 최소 길이 설정
cat << EOF >> $RESULT
[ 양호 ] : 패스워드 최소 길이가 8자 이상으로 되어 있는 경우
[ 취약 ] : 패스워드 최소 길이가 8자 미만으로 되어 있는 경우
EOF
BAR

TMP1=`SCRIPTNAME`.log
> $TMP1
TMP2=$(mktemp)

INFO_FILE=$(cat /etc/login.defs | egrep -v '^#|^$' | grep PASS_MIN_LEN)
CHECK_FILE=$(cat /etc/login.defs | egrep -v '^#|^$' | grep PASS_MIN_LEN | awk '{print $2}')

if [ $CHECK_FILE -lt 8 ] ; then
WARN "패스워드 최소 길이가 8자 미만으로 설정되어 있는 경우입니다."
INFO $INFO_FILE
else
OK "패스워드 최소 길이가 8자 이상으로 설정되어 있습니다."
INFO $INFO_FILE
fi

cat $RESULT
echo; echo
