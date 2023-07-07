#!/bin/bash
. ../function.sh

BAR
CODE [U-58] 홈 디렉터리로 지정한 디렉터리의 존재 관리
cat << EOF >> $RESULT
[ 양호 ] : 홈 디렉터리가 존재하지 않는 계정이 발견되지 않는 경우
[ 취약 ] : 홈 디렉터리가 존재하지 않는 계정이 발견된 경우
EOF
BAR

TMP=$(mktemp)
FILE=/etc/passwd

cat /etc/passwd | awk -F: '$3 >= 1000 && $3 < 60000 {print $1, $6}' > $TMP

cat $TMP | while read NAME HOMEDIR
do
if [[ -z $HOMEDIR ]] || [[ $HOMEDIR == '/' ]] ; then
WARN $NAME 계정의 홈 디렉터리가 존재하지 않거나, / 로 설정되어 있습니다.
INFO $FILE 파일을 확인해주세요.
else
OK $NAME 계정의 홈 디렉터리 설정이 양호합니다.
fi
done

cat $RESULT
echo; echo
