#!/bin/bash
. ../function.sh

BAR
CODE [U-04] 패스워드 파일 보호
cat << EOF >> $RESULT
[ 양호 ] : 쉐도우 패스워드를 사용하거나, 패스워드를 암호화하여 저장하는 경우
[ 취약 ] : 쉐도우 패스워드를 사용하지 않고, 패스워드를 암호화하지 않고 저장하는 경우
EOF
BAR

PASSFILE=/etc/passwd
SHADOWFILE=/etc/shadow

if [ -f $PASSFILE -a -f $SHADOWFILE ] ; then
Ret=$(CheckEncryptedPasswd $SHADOWFILE)
case $Ret in
None) WARN "쉐도우 패스워드를 사용하지만, 패스워드가 암호화되어 있지 않습니다." ;;
TrueTrue) OK "쉐도우 패스워드를 사용하거나, 패스워드를 암호화하여 저장하고 있습니다." ;;
WarnTrue) OK "쉐도우 패스워드를 사용하거나, 패스워드를 암호화하여 저장하고 있습니다." INFO "SHA-512 알고리즘을 사용할 것을 권장합니다." ;;
*) : ;;
esac
else
WARN "쉐도우 패스워드를 사용하지 않고 있습니다."
fi

cat $RESULT
echo; echo
