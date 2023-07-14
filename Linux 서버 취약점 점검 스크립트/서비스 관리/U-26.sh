#!/bin/bash
. ../function.sh

TMP=`SCRIPTNAME`.log
> $TMP

BAR
CODE [U-26] automountd 제거
cat << EOF >> $RESULT
[ 양호 ] : automountd 서비스가 비활성화 되어 있는 경우
[ 취약 ] : automountd 서비스가 활성화 되어 있는 경우
EOF
BAR

SERVICE=automountd

ps -ef | grep automount | grep -v grep > $TMP
if [ -s $TMP ] ; then
WARN $SERVICE 서비스가 활성화 되어 있습니다.
INFO $TMP 파일을 확인해야 합니다.
else
OK $SERVICE 서비스가 비활성화 되어 있습니다.
fi

cat $RESULT
echo; echo
