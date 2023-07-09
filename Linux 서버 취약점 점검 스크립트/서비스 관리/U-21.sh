#!/bin/bash
. ../function.sh

TMP=`SCRIPTNAME`.log
> $TMP

BAR
CODE [U-21] r 계열 서비스 비활성화
cat << EOF >> $RESULT
[ 양호 ] : r 계열 서비스가 비활성화가 되어 있는 경우
[ 취약 ] : r 계열 서비스가 활성화 되어 있는 경우
EOF
BAR

SERVICE_LIST='rlogin.socket rexec.socket rsh.socket'
for SERVICE in $SERVICE_LIST
do
STATUS=$(systemctl is-enabled $SERVICE)
if [ $STATUS = 'enabled' ] ; then
echo "[ WARN ] $SERVICE is Enabled" >> $TMP
else
echo "[ OK ] $SERVICE is Disabled" >> $TMP
fi
done

if grep -q WARN $TMP ; then
WARN "r 계열 서비스가 활성화 되어 있습니다."
INFO "$TMP 파일의 내용을 참고하세요."
else
OK "r 계열 서비스가 비활성화 되어 있습니다."
fi

cat $RESULT
echo; echo
