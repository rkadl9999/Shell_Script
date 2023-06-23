#!/bin/bash
. ../function.sh

TMP=`SCRIPTNAME`.log
> $TMP

BAR
CODE [U-03] 계정 잠금 임계값 설정
cat << EOF >> $RESULT
[ 양호 ] : 계정 잠금 임계값이 5 이하의 값으로 설정되어 있는 경우
[ 취약 ] : 계정 잠금 임계값이 설정되어 있지 않거나, 5 이하의 값으로 설정되지 않은 경우
EOF
BAR

PAM_SYSTEM_AUTH=/etc/pam.d/system-auth

Ret1=$(PAM_FindPatternReturnValue $PAM_SYSTEM_AUTH pam_tally2.so deny)
Ret2=$(PAM_FindPatternReturnValue $PAM_SYSTEM_AUTH pam_tally2.so unlock_time)

if [ "$Ret1" != None -a "$Ret2" != None ] ; then
if [ $Ret1 -le 5 ] ; then
OK "계정 잠금 임계값이 5 이하의 값으로 설정되어 있습니다."
else
WARN "계정 잠금 임계값이 설정되어 있지만, 5 이상의 값으로 설정되어 있습니다."
fi
else
WARN "계정 잠금 임계값이 설정되어 있지 않습니다."
fi

cat $RESULT
echo ; echo
