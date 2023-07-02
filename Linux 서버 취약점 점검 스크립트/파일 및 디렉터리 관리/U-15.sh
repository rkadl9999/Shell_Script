#!/bin/bash
. ../function.sh

TMP=`SCRIPTNAME`.log
> $TMP

BAR
CODE [U-15] world writable 파일 점검
cat << EOF >> $RESULT
[ 양호 ] : world writable 파일이 존재하지 않거나, 존재 시 설정 이유를 확인하고 있는 경우
[ 취약 ] : world writable 파일이 존재하고 해당 설정 이유를 확인하고 있지 않은 경우
EOF
BAR

find / -perm -2 -ls 2> /dev/null | egrep -v '(/proc|lrwx|/tmp)' | awk {'print $3, $11'} | egrep -v '^(s|d|c|b)' > $TMP

if [ -s $TMP ] ; then
WARN world writable 파일이 존재합니다.
INFO $TMP 파일을 확인하세요.
else
OK world writable 파일이 존재하지 않습니다.
fi

cat $RESULT
echo; echo
