#!/bin/bash
. ../function.sh

TMP1=`SCRIPTNAME`.log
> $TMP1

BAR
CODE [U-06] 파일 및 디렉터리 소유자 설정
cat << EOF >> $RESULT
[ 양호 ] : 소유자가 존재하지 않는 파일 및 디렉터리가 존재하지 않는 경우
[ 취약 ] : 소유자가 존재하지 않는 파일 및 디렉터리가 존재하는 경우
EOF
BAR

TMP2=$(mktemp)
find / -nouser -o -nogroup -print 2> /dev/null > $TMP2
if [ -s $TMP2 ] ; then
WARN 소유자가 존재하지 않는 파일 및 디렉터리가 있습니다.
INFO $TMP1 파일의 내용을 참고합니다.
echo "다음 명령어가 실행된 결과입니다." >> $TMP1
echo "CMD : find / -nouser -o -nogroup -print 2> /dev/null" >> $TMP1
echo "=========================================================================" >> $TMP1
cat $TMP2 >> $TMP1
else
OK 소유자가 존재하지 않는 파일 및 디렉터리가 없습니다.
fi

cat $RESULT
echo; echo
