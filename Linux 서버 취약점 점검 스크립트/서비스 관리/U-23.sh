#!/bin/bash
. ../function.sh

TMP=`SCRIPTNAME`.log
> $TMP

BAR
CODE [U-23] DoS 공격에 취약한 서비스 비활성화
cat << EOF >> $RESULT
[ 양호 ] : 사용하지 않는 DoS 공격에 취약한 서비스가 비활성화 된 경우
[ 취약 ] : 사용허자 않는 DoS 공격에 취약한 서비스가 활성화 된 경우
EOF
BAR

SERVICE=$(mktemp)
ls /etc/xinetd.d/ | grep '^echo\|^discard\|^daytime\|^chargen' > $SERVICE

cat $SERVICE | while read FILENAME
do
DISABLE=$(cat /etc/xinetd.d/$FILENAME | grep disable | awk '{print $3}')
if [ $DISABLE = 'yes' ] ; then
echo "[ OK ] $FILENAME 서비스가 비활성화 되어 있습니다." >> $TMP
else
echo "[ WARN ] $FILENAME 서비스가 활성화 되어 있습니다." >> $TMP
fi
done

INFO $TMP 파일을 확인해주세요.

cat $RESULT
echo; echo
