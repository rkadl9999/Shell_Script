#!/bin/bash
. ../function.sh

TMP1=`SCRIPTNAME`.log
> $TMP1

BAR
CODE [U-54] Session Timeout 설정
cat << EOF >> $RESULT
[ 양호 ] : Session Timeout이 600초(10분) 이하로 설정되어 있는 경우
[ 취약 ] : Session Timeout이 600초(10분) 이하로 설정되지 않은 경우
EOF
BAR

PASS_FILE=/etc/passwd
TMP2=/tmp/tmp2
> $TMP2

awk -F: '$3 >= 1000 && $3 <= 60000 {print $1}' $PASS_FILE > $TMP2

for user in $(cat $TMP2)
do
TMOUT_USER=$user
TMOUT_OUTPUT=$(su -$TMOUT_USER -c 'echo $TMOUT')
if [ -z $TMOUT_OUTPUT ] ; then
echo "[ WARN ] $TMOUT_USER : $TMOUT_OUTPUT" >> $TMP1
else
if [ $TMOUT_OUTPUT -le 600 ] ; then
echo "[ OK ] $TMOUT_USER : $TMOUT_OUTPUT" >> $TMP1
else
echo "[ WARN ] $TMOUT_USER : $TMOUT_OUTPUT" >> $TMP1
fi
fi
done

if grep -q -w WARN $TMP1 ; then
WARN "Session Timeout이 없거나 600초(10분) 이하로 설정되지 않은 경우"
else
OK "Session Timeout이 600초(10분) 이하로 설정되어 있는 경우"
fi
INFO $TMP1 "파일의 내용을 참고합니다."

cat $RESULT
echo; echo
