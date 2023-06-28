#!/bin/bash
. ../function.sh

TMP=`SCRIPTNAME`.log
> $TMP

BAR
CODE "[U-05] root 홈, 패스(PATH) 디렉터리 권한 및 패스(PATH) 설정"
cat << EOF >> $RESULT
[ 양호 ] : PATH 환경변수에 "."이 맨 앞이나 중간에 포함되지 않은 경우
[ 취약 ] : PATH 환경변수에 "."이 맨 앞이나 중간에 포함되어 있는 경우
EOF
BAR

ROOTPATH=$(su - root -c 'echo $PATH')
CHECKPATH=$(echo $ROOTPATH | egrep '^:|:$|::|^.:|:.:|:.$')
if [ -z $CHECKPATH ] ; then
OK PATH 환경변수에 "."이 맨 앞이나 중간에 포함되지 않았습니다.
else
WARN PATH 환경변수에 "."이 맨 앞이나 중간에 포함되어 있습니다.
INFO $TMP 파일을 참고 하십시오.
echo "======================================================================" >> $TMP
echo "* root 사용자의 PATH 변수 내용입니다." >> $TMP
echo "$CHECKPATH" >> $TMP
echo "======================================================================" >> $TMP
fi

cat $RESULT
echo; echo
