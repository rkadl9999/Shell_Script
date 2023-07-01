#!/bin/bash
. ../function.sh

TMP=`SCRIPTNAME`.log
> $TMP

BAR
CODE [U-13] SUID, SGID, Sticky bit 설정 파일 점검
cat << EOF >> $RESULT
[ 양호 ] : 주요 파일의 권한에 SUID와 SGID에 대한 설정이 부여되어 있지 않은 경우
[ 취약 ] : 주요 파일의 권한에 SUID와 SGID에 대한 설정이 부여되어 있는 경우
EOF
BAR

cat nosetuid.txt | while read TMP2
do
if [ -e $TMP2 ] ; then
if [ $? -eq 0 ] ; then
WARN "$TMP2"
else
OK "$TMP2"
fi
fi
done

cat $RESULT
echo; echo
