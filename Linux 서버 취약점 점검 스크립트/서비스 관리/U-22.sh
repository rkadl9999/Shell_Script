#!/bin/bash
. ../function.sh

TMP=`SCRIPTNAME`.log
> $TMP

BAR
CODE cron 파일 소유자 및 권한 설정
cat << EOF >> $RESULT
[ 양호 ] : cron 접근제어 파일 소유자가 root이고, 권한이 640 이하인 경우
[ 취약 ] : cron 접근제어 파일 소유자가 root가 아니거나, 권한이 640 이하가 아닌 경우
EOF
BAR

allow=/etc/cron.allow
deny=/etc/cron.deny
CHECK=-1

if [ -e $allow ] ; then
AllowPerm=$(CheckPerm $allow)
AllowOwner=$(CheckOwner $allow)
if [ $AllowOwner = 'root' ] ; then
if [ $AllowPerm -eq 640 ] ; then
((CHECK++))
fi
fi
echo "[ INFO ] $allow 파일의 권한 = $AllowPerm, 소유자 = $AllowOwner" >> $TMP
else
echo "[ INFO ] $allow 파일이 존재하지 않습니다." >> $TMP
((CHECK++))
fi

if [ -e $deny ] ; then
DenyPerm=$(CheckPerm $deny)
DenyOwner=$(CheckOwner $deny)
if [ $DenyOwner = 'root' ] ; then
if [ $DenyPerm -lt 640 ] ; then
((CHECK++))
fi
fi
echo "[ INFO ] $deny 파일의 권한 = $DenyPerm, 소유자 = $DenyOwner" >> $TMP
else
echo "[ INFO ] $deny 파일이 존재하지 않습니다." >> $TMP
((CHECK++))
fi

if [ $CHECK -eq 1 ] ; then
OK cron 접근제어 파일 소유자가 root이고, 권한이 640 이하로 설정되어 있습니다.
else
WARN cron 접근제어 파일 소유자가 root가 아니거나, 권한이 640 이하가 아닙니다.
INFO $TMP 파일을 확인해주세요.
fi

cat $RESULT
echo; echo
