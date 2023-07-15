#!/bin/bash
. ../function.sh

TMP=`SCRIPTNAME`.log
> $TMP

BAR
CODE [U-27] RPC 서비스 확인
cat << EOF >> $RESULT
[ 양호 ] : 불필요한 RPC 서비스가 비활성화 되어 있는 경우
[ 취약 ] : 불필요한 RPC 서비스가 활성화 되어 있는 경우
EOF
BAR

cat << EOF >> RPC_Service_list
rpc.cmsd
cmsd
rpc.ttdbserverd
ttdbserverd
sadmind
rusersd
walld
sprayd
rstatd
rpc.nisd
rexd
rpc.pcnfsd
pcnfsd
rpc.statd
rpc.ypupdated
rquotad
kcms_server
cachfsd
EOF

SERVICE=RPC_Service_list
XINETD=/etc/xinetd.d

INFO $TMP 파일을 참고해주세요.

for i in $(cat $SERVICE)
do
ls $XINETD/$i* > /dev/null 2>&1
if [ $? != 0 ]; then
echo "[ OK ] $i 파일이 존재하지 않습니다." >> $TMP
else
for j in $(ls $XINETD/$i*)
do
echo "[ INFO ] $i 파일이 존재합니다." >> $TMP
if [ $(cat $j | grep disable | awk '{print $3}') = "yes" ]; then
OK $j 파일에 대한 서비스가 비활성화 되어 있습니다.
else
WARN $j 파일에 대한 서비스가 활성화 되어 있습니다.
fi
done
fi
done

rm RPC_Service_list

cat $RESULT
echo; echo
