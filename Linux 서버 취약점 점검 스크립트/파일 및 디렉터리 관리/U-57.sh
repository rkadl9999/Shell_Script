#!/bin/bash
. ../function.sh

BAR
CODE [U-57] 홈 디렉터리 소유자 및 권한 설정
cat << EOF >> $RESULT
[ 양호 ] : 홈 디렉터리 소유자가 해당 계정이고 일반 사용자 쓰기 권한이 제거된 경우
[ 취약 ] : 홈 디렉터리 소유자가 해당 계정이 아니고 일반 사용자 쓰기 권한이 부여된 경우
EOF
BAR

TMP1=$(mktemp)
TMP2=$(mktemp)
TRUEFALSE=1

cat /etc/passwd | awk -F: '$3 >= 1000 && $3 < 60000 {print $1, $6}' > $TMP1

cat $TMP1 | while read USERNAME HOMEDIR
do
NAME=`ls -ald $HOMEDIR | awk '{print $3}'`
PERM=`ls -ald $HOMEDIR | awk '{print $1}'`
find $HOMEDIR -type d -perm -600 -ls | grep -v drwx------ | grep $HOMEDIR$ > $TMP2
if [ -s $TMP2 ] ; then
WARN $USERNAME 사용자의 홈 디렉터리 $HOMEDIR 권한을 확인하세요.
TRUEFALSE=0
fi
if [ $USERNAME != $NAME ] ; then
WARN $USERNAME 사용자의 홈 디렉터리 $HOMEDIR 소유자를 확인하세요.
fi
if [[ ! -s $TMP2 ]] && [[ $USERNAME = $NAME ]]; then
OK $USERNAME 사용자의 홈 디렉터리 소유자와 권한 설정이 양호합니다.
fi
done

cat $RESULT
echo; echo
