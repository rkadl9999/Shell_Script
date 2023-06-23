#/bin/bash
. ../function.sh

TMP=`SCRIPTNAME`.log
> $TMP

BAR
CODE [U-05] root 이외의 UID가 '0'금지
cat << EOF >> $RESULT
[ 양호 ] : root 계정과 동일한 UID를 가지는 계정이 존재하지 않는 경우
[ 취약 ] : root 계정과 동일한 UID를 가지는 계정이 존재하는 경우
EOF
BAR

PASSFILE=/etc/passwd
awk -F: '$3 == "0" {print $1}' $PASSFILE >> TMP
UIDZEROCOUNT=$(wc -l < $TMP)
if [ $UIDZEROCOUNT -ge 2 ] ; then
WARN "root 계정과 동일한 UID를 갖는 계정이 존재합니다."
INFO $TMP 참고 하십시오.
else
OK "root 계정과 동일한 UID를 갖는 계정이 없습니다."
fi

cat $RESULT
echo; echo
