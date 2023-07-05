#!/bin/bash
. ../function.sh

BAR
CODE '[U-17] $HOME/.rhosts, hosts.equiv 사용 금지'
cat << EOF >> $RESULT
[ 양호 ] : login, shell, exec 서비스를 사용하지 않거나 사용시 아래와 같은 설정이 적용된 경우
1. /etc/hosts.equiv 및 $HOME/.rhosts 파일 소유자가 root 또는 해당 계정인 경우
2. /etc/hosts.equiv 및 $HOME/.rhosts 파일 권한이 600 이하인 경우
3. /etc/hosts.equiv 및 $HOME/.rhosts 파일 설정에 '+' 설정이 없는 경우
[ 취약 ] : login, shell, exec 서비스를 사용하고, 위와 같은 설정이 적용되지 않은 경우
EOF
BAR

TMP1=$(mktemp)
TMP2=$(mktemp)
TUREFALSE=1

cat /etc/passwd | awk -F: '$3 >= 1000 && $3 < 60000 {print $1}' > $TMP1
sed -i 's\^\/home/\g' $TMP1
echo root >> $TMP1

ls -al /etc/hosts.equiv > $TMP2 2> /dev/null

if [ $? -eq 0 ] ; then
LINE1=`cat $TMP2 | awk '{print $3}'`
LINE2=`cat /etc/hosts.equiv | grep + `
if [ -n $LINE2 -o $LINE1 != root ] ; then
WARN /etc/hosts.equiv 파일의 소유자 및 '+'설정을 점검하십시오. 
TUREFALSE=0
fi
find /etc/hosts.equiv -perm -600 | grep -v 'rw-------' > /dev/null 2>&1
if [ $? -eq 0 ] ; then
WARN /etc/hosts.equiv 파일의 권한을 점검하세요.
TUREFALSE=0
fi
fi 

>$TMP2
 
for i in `cat $TMP1`
do
ls -al $i/.rhosts >> $TMP2 2>/dev/null
done

if [ -s $TMP2 ] ; then
for i in `cat $TMP1`
do
LINE1=`cat $TMP2 | awk '{print $3}'`
LINE2=`cat $i/.rhosts | grep + `
if [ $LINE1 != $i -o $LINE1 != root -o -n $LINE2 ] ; then
WARN $i/.rhosts 파일의 소유자 및 '+'설정을 점검하십시오. 
TUREFALSE=0
fi 
find $i/.rhosts -perm -600 | grep -v 'rw-------' > /dev/null 2>&1
if [ $? -eq 0 ] ; then
WARN $i/.rhosts 파일의 퍼미션을 점검하십시오. 
TUREFALSE=0
fi
done
fi

if [ $TUREFALSE -eq 1 ] ; then
OK /etc/hosts.equiv 및 사용자의 .rhosts 파일 설정이 양호합니다.
fi

cat $RESULT
echo; echo
