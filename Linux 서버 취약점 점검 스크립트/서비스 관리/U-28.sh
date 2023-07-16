#!/bin/bash
. ../function.sh

TMP=`SCRIPTNAME`.log
> $TMP

BAR
CODE [U-28] NIS, NIS+ 점검
cat << EOF >> $RESULT
[ 양호 ] : NIS 서비스가 비활성화 되어 있거나, 필요시 NIS+를 사용하는 경우
[ 취약 ] : NIS 서비스가 활성화 되어 있는 경우
EOF
BAR

ps -ef | egrep "ypserv|ypbind|ypxfrd|rpc.yppasswdd|rpc.ypupdated" | grep -v grep > $TMP
if [ -s $TMP ]; then
WARN 불필요한 서비스들이 활성화 되어 있습니다.
INFO $TMP 파일을 확인해주세요.
else
OK 불필요한 서비스들이 비활성화 되어 있습니다.
rm $TMP
fi

cat $RESULT
echo; echo
