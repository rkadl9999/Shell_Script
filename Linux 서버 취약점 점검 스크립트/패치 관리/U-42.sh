#!/bin/bash
. ../function.sh

BAR
CODE [U-42] 최신 보안패치 및 벤더 권고사항 적용
cat << EOF >> $RESULT
[ 양호 ] : 패치 적용 정책을 수립하여 주기적으로 패치관리를 하고 있으며, 패치 관련 내용을 확인하고 적용했을 경우
[ 취약 ] : 패치 적용 정책을 수립하지 않고 주기적으로 패치관리를 하고 있지 않거나 패치 관련 내용을 확인하지 않고 적용하지 않았을 경우
EOF
BAR

INFO 패치 업데이트를 시작합니다.
UPDATE=`yum update | grep 'No packages marked for update'`

if [ -n "$UPDATE" ]; then
	OK 이미 최신 버전입니다.
else
	OK 업데이트가 완료되었습니다.
fi

cat $RESULT
echo; echo 
