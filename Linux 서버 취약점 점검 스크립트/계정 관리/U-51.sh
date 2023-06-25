#!/bin/bash
. ../function.sh

TMP1=`SCRIPTNAME`.log
TMP2=/tmp/tmp1
TMP3=/tmp/tmp2
TMP4=/tmp/tmp3

BAR
CODE [U-51] 계정이 존재하지 않는 GID 금지
cat << EOF >> $RESULT
[ 양호 ] : 존재하지 않는 계정에 GID 설정을 금지한 경우
[ 취약 ] : 존재하지 않는 계정에 GID 설정이 되어있는 경우
EOF
BAR

GROUPFILE=/etc/group
/bin/cp $GROUPFILE $TMP2
for i in $(cat $GROUPFILE | awk -F: '{print $4}')
do
if [ ! -z "$i" ] ; then
sed -i "/:${i}/d" $TMP2
fi
done

awk -F: '{print $4}' /etc/passwd > $TMP3
for j in $(cat $TMP2)
do
NUM=$(echo $j | awk -F: '{print $3}')
if grep -wq $NUM $TMP3 ; then
:
else
echo $j >> $TMP4
fi
done

if [ -s $TMP4 ] ; then
WARN 존재하지 않는 계정에 GID 설정이 되어 있습니다.
INFO $TMP1 파일을 참고합니다.
cat << EOF >> $TMP1
================================================================================
1. 사용자가 포함되지 않은 그룹 이름의 목록을 /etc/group에서 검색하였습니다.

$(cat $TMP4)
================================================================================
EOF
else
OK 존재하지 않는 계정에 GID 설정이 금지 되어 있습니다.
fi

cat $RESULT
echo; echo
