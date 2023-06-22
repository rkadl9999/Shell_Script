#!/bin/bash
. ../function.sh
TMP1=$(SCRIPTNAME).log
> $TMP1

BAR
CODE [U-02] 패스워드 복잡성 검사
cat << EOF >> $RESULT
[ 양호 ] : 영문, 숫자, 특수문자가 혼합된 8글자 이상의 패스워드가 설정된 경우.
[ 취약 ] : 영문, 숫자, 특수문자가 혼합되지 않은 8글자 미만의 패스워드가 설정된 경우.
EOF
BAR

INFO $TMP1 파일을 점검한다.
echo >> $TMP1
echo
echo "다음은 /etc/security/pwquality.conf 파일을 해석할 때 사용하는 내용입니다."
echo "=====================================================================================">> $TMP1
cat /etc/security/pwquality.conf | egrep -v '(^$|^#)' >> $TMP1

cat << EOF >> $TMP1
===========================================================================================
다음은 /etc/security/pwquality.conf 파일을 해석할 때 사용하는 내용입니다.

minlen : 패스워드 최소 길이입니다.
minclass : 패스워드 class 지정입니다.
lcredit : 패스워드 소문자 포함 지정입니다.
ucredit : 패스워드 대문자 포함 지정입니다.
dcredit : 패스워드 숫자 포함 지정입니다.
ocredit : 패스워드 특수문자 포함 지정입니다.
===========================================================================================
다음은 /etc/security/pwquality.conf 파일의 내용이 없으면,

1) 기본 값을 사용하는 경우입니다. 이 경우, 패스워드 정책에 맞지 않습니다.
따라서, 반드시 정책을 변경할 것을 권장합니다.
2) 정책을 변경하는 경우에는 다음과 같은 명령어를 통해 설정할 수 있습니다.
# authconfig --passminlen=8 --passminclass=3
--enablereqlower --disablerequpper --enablereqdigit
--enablereqother --update
===========================================================================================
EOF

PWQUALITY_CONF=/etc/security/pwquality.conf
VALUE1=$(FindPatternReturnValue $PWQUALITY_CONF minlen)
if [ $VALUE1 -lt 8 ] ; then
WARN '패스워드의 최소 길이 설정이 8글자 미만으로 되어 있습니다.'
else
if [ $VALUE1 -ge 8 ] ; then
Ret1=$(IsFindPattern $PWQUALITY_CONF dcredit)
Ret2=$(IsFindPattern $PWQUALITY_CONF ucredit)
Ret3=$(IsFindPattern $PWQUALITY_CONF lcredit)
Ret4=$(IsFindPattern $PWQUALITY_CONF ocredit)
if [ $Ret1 -eq 0 -a $Ret2 -eq 0 -a $Ret3 -eq 0 -a $Ret4 -eq 0 ] ; then
OK "영문, 숫자, 특수문자가 혼합된 8글자 이상의 패스워드를 사용하고 있습니다."
else
WARN "패스워드가 8글자 이상이지만 dcredit|ucredit|lcredit|ocredit 중 설정이 없는 것이 존재합니다."
fi
else
WARN "패스워드의 최소 길이 설정이 8글자 미만으로 되어 있습니다."
fi
fi

cat $RESULT
echo
