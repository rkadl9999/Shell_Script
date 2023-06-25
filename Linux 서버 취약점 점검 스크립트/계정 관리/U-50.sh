#!/bin/bash
. ../function.sh

TMP1=`SCRIPTNAME`.log
> $TMP1
TMP2=$(mktemp)

BAR
CODE [U-50] 관리자 그룹에 최소한의 계정 포함
cat << EOF >> $RESULT
[ 양호 ] : 관리자 그룹에 불필요한 계정이 등록되어 있지 않은 경우
[ 취약 ] : 관리자 그룹에 불필요한 계정이 등록되어 있는 경우
EOF
BAR

INFO $TMP1 파일을 참고하여 고객과 상의하여 주세요.

GROUPFILE=/etc/group
grep -E '^(root|bin|daemon|sys|adm|tty|disk|mem|kmem|wheel):' $GROUPFILE >> $TMP2

echo
cat << EOF >> $TMP1
======================================================================================
1. /etc/group 파일의 내용입니다.

* 다음 사항을 점검합니다.

* 1) root, bin, daemon, sys, adm, tty, disk, mem, kmem, wheel 그룹에 속한 사용자가
반드시 필요한 사용자인지 확인한다.
* 2) 4번째 필드가 그룹에 속한 사용자 목록이다.
* 3) 사용자 목록이 없으면, 양호이다.
======================================================================================
$(cat $TMP2)
======================================================================================
EOF

rm -f $TMP2

cat $RESULT
echo; echo
