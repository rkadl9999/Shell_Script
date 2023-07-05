#!/bin/bash
. ../function.sh

BAR
CODE [U-56] UMASK 설정 관리
cat << EOF >> $RESULT
[ 양호 ] : UMASK 값이 022 이하로 설정된 경우
[ 취약 ] : UMASK 값이 022 이하로 설정되지 않은 경우
EOF
BAR

UMASK=`umask`

if [ $UMASK -le 0022 ] ; then
OK UMASK 값이 022 이하로 설정되어 있습니다.
else
WARN UMASK 값이 022 이하로 설정되어 있지 않습니다.
INFO /etc/profile 파일을 수정하세요.
fi

cat $RESULT
echo; echo
