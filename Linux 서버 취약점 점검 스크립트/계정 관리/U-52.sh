#!/bin/bash
. ../function.sh

TMP1=`SCRIPTNAME`.log
> $TMP1

TMP2=$(mktemp)
TMP3=$(mktemp)
> $TMP2
> $TMP3

BAR
CODE [U-52] 동일한 UID 금지
cat << EOF >> $RESULT
[ 양호 ] : 동일한 UID로 설정된 사용자 계정이 존재하지 않는 경우
[ 취약 ] : 동일한 UID로 설정된 사용자 계정이 존재하는 경우
EOF
BAR

PASS_FILE=/etc/passwd
awk -F: '{print $3}' $PASS_FILE | sort -n | uniq -d > $TMP2
if [ -s $TMP2 ] ; then
WARN '동일한 UID로 설정된 사용자 계정이 존재합니다.'
INFO '자세한 내용은 $TMP1 파일을 참고하세요.'
cat << EOF >> $TMP1
===================================================================================
다음 내용은 /etc/passwd 파일의 내용 중 UID가 중복된 사용자의 정보입니다.
ex ) $ awk -v CHECK=1001 -F: '$3 == CHECK {print $0}' /etc/passwd
===================================================================================
EOF
for user in $(cat $TMP2)
do
awk -v CHECK=$user -F: '$3 == CHECK {print $0}' $PASS_FILE >> $TMP1
done
else
OK '동일한 UID로 설정된 사용자 계정이 존재하지 않습니다.'
fi
cat $TMP2

cat $RESULT
echo; echo
