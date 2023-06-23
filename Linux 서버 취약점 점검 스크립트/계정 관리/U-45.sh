#!/bin/bash
. ../function.sh

BAR
CODE [U-45] root 계정 su 제한
cat << EOF >> $RESULT
[ 양호 ] : su 명령어를 특정 그룹에 속한 사용자만 사용하도록 제한되어 있는 경우
[ 취약 ] : su 명령어를 모든 사용자가 사용하도록 설정되어 있는 경우
EOF
BAR

PAM_FILE=/etc/pam.d/su
PAM_MODULE=pam_wheel.so
GROUP_FILE=/etc/group

egrep -v '^#|^$' $PAM_FILE | grep -q $PAM_MODULE
if [ $? -eq 0 ] ; then
INFO "pam_wheel.so 모듈을 사용하고 있습니다."
if grep -q wheel $GROUP_FILE ; then
INFO "wheel 그룹이 존재합니다."
else
INFO "wheel 그룹이 존재하지 않습니다."
fi
OK "su 명령어를 특정 그룹에 속한 사용자만 사용하도록 제한되어 있는 경우입니다."
else
WARN "su 명령어를 가진 모든 사용자가 사용하도록 설정되어 있는 경우입니다."
fi

cat $RESULT
echo; echo
