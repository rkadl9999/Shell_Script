#!/bin/bash
. ../function.sh

BAR
CODE [U-30] Sendmail 버전 점검
cat << EOF >> $RESULT
[ 양호 ] : Sendmail 버전이 8.13.8 이상인 경우
[ 취약 ] : Sendmail 버전이 8.13.8 이상이 아닌 경우
EOF
BAR

STATUS=`ps -ef | grep sendmail | grep -v grep`

if [ -z "$STATUS" ]; then
	OK sendmail 서비스가 비활성화 되어 있습니다.
else
	VER=`yum list | grep sendmail | grep @base | awk '{print $2}' | awk -F- '{print $1}'`
	LowVER=`printf '%s\n' "$VER" "8.13.8" | sort -V | head -n 1`
	if [ $LowVER == $VER ]; then
		WARN 오래된 sendmail 버전을 사용하고 있습니다. 패키지를 업데이트 해주세요.
	else
		OK 8.13.8 보다 높은 버전의 sendmail을 사용하고 있습니다.
	fi
fi		 

cat $RESULT
echo; echo
