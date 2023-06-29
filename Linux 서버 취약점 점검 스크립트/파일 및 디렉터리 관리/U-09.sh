#!/bin/bash
. ../function.sh

TMP=`SCRIPTNAME`.log
> $TMP

BAR
CODE [U-09] /etc/hosts 파일 소유자 및 권한 설정
cat << EOF >> $RESULT
[ 양호 ] : /etc/hosts 파일의 소유자가 root이고, 권한이 600인 경우
[ 취약 ] : /etc/hosts 파일의 소유자가 root가 아니거나, 권한이 600이 아닌 경우
EOF
BAR

CHECKFILE=/etc/hosts
OWNER=$(ls -l $CHECKFILE | awk '{print $3}')
CHECKPERM=$(stat -c "%a" $CHECKFILE)

if [ $OWNER = 'root' ] ; then
OK "파일의 소유자가 root 입니다."
if [ $CHECKPERM -eq 600 ] ; then
OK "파일의 권한이 600 입니다."
else
WARN "파일의 권한이 600이 아닙니다."
echo "$CHECKFILE 의 권한이 $CHECKPERM 으로 되어 있습니다." > $TMP
INFO "권한 설정 상태는 $TMP 파일에서 확인하세요."
fi
else
WARN "파일의 소유자가 root가 아닙니다."
fi

cat $RESULT
echo; echo
