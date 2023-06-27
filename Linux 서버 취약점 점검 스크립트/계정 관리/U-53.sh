#!/bin/bash
. ../function.sh

TMP1=`SCRIPTNAME`.log
> $TMP1
TMP2=/tmp/tmp1
> $TMP2

BAR
CODE [U-53] 사용자 Shell 점검
cat << EOF >> $RESULT
[ 양호 ] : 로그인이 필요하지 않은 계정에 /bin/false(nologin) 쉘이 부여되어 있는 경우
[ 취약 ] : 로그인이 필요하지 않은 계정에 /bin/false(nologin) 쉘이 부여되지 않은 경우
EOF
BAR

PASS_FILE=/etc/passwd

# (1) 점검해야 하는 사용자 목록 생성
grep '^\(daemon\|bin\|adm\|lp\|mail\|operator\|games\|ftp\|nobody\|dbus\|rpc\|rpcuser\|nfsnobody\|sshd\|postfix\):' /etc/passwd | grep -v '/sbin/nologin$'

if [ -s $TMP2 ] ; then
WARN 로그인이 필요하지 않은 계정에 로그인 쉘이 부여되어 있습니다.
INFO $TMP1 파일의 내용을 참고하십시오.
cat << EOF >> $TMP1
================================================================================================
* 로그인이 필요하지 않지만 로그인 가능 쉘이 부여된 사용자 목록입니다.

$(cat $TMP2)
================================================================================================
EOF
else
OK 로그인이 필요하지 않은 계정에 로그인 쉘이 부여되어 있지 않습니다.
fi

cat $RESULT
echo; echo
