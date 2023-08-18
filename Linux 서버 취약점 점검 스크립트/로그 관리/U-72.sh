#!/bin/bash
. ../function.sh

TMP=`SCRIPTNAME`.log
> $TMP

BAR
CODE [U-72] 정책에 따른 시스템 로깅 설정
cat << EOF >> $RESULT
[ 양호 ] : 로그 기록 정책이 정책에 따라 설정되어 수립되어 있는 경우
[ 취약 ] : 로그 기록 정책 미수립, 또는 정책에 따라 설정되어 있지 않은 경우
EOF
BAR

INFO 1. 편집기를 이용하여 /etc/rsyslog.conf 파일을 열어주세요.
INFO 2. $TMP 파일에 작성되어 있는 값을 수정 또는 신규 삽입 해주세요.
echo "*.emerg                                                    *

*.alert                                                     /dev/console

*.alert                                                     /var/adm/alert.log

*.err                                                       /var/adm/error.log

mail.info                                                   /var/adm/mail.log

auth.info                                                   /var/adm/auth.log

daemon.info                                                 /var/adm/daemon.log

*.emerg;*.alert;*.crit;*.err;*.warning;*.notice;*.info      /var/adm/messages" > $TMP
INFO 3. rsyslog 데몬을 재시작하여 적용해주세요.

cat $RESULT
echo; echo
