#!/bin/bash
. ../function.sh

TMP=`SCRIPTNAME`.log
> $TMP

BAR
CODE [U-16] /dev에 존재하지 않는 device 파일 점검
cat << EOF >> $RESULT
[ 양호 ] : dev에 대한 파일 점검 후 존재하지 않는 device 파일을 제거한 경우
[ 취약 ] : dev에 대한 파일 미점검, 또는 존재하지 않는 device 파일을 방치한 경우
EOF
BAR

find /dev -type f -exec ls -l {} \; > $TMP

if [ -s $TMP ] ; then
WARN "파일이 존재합니다."
INFO "$TMP 파일을 확인해주세요."
else
OK "파일이 존재하지 않습니다."
fi

cat $RESULT
echo; echo
