#!/bin/bash
. ../function.sh

BAR
CODE [U-14] 사용자, 시스템 시작파일 및 환경파일 소유자 및 권한 설정
cat << EOF >> $RESULT
[ 양호 ] : 홈 디렉터리 환경변수 파일 소유자가 root 또는 해당 계정으로 지정되어 있고
홈 디렉터리 환경변수 파일에 root와 소유자만 쓰기 권한이 부여된 경우
[ 취약 ] : 홈 디렉터리 환경변수 파일 소유자가 root 또는 해당 계정으로 지정되지 않고
홈 디렉터리 환경변수 파일에 root와 소유자 외에 쓰기 권한이 부여된 경우
EOF
BAR

TMP1=$(mktemp)
TMP2=$(mktemp)
TMP3=$(mktemp)
TRUEFALSE=1

cat /etc/passwd | awk -F: '$3 >= 500 && $3 < 60000 && $7 != "/sbin/nologin" {print $1}' > $TMP1

for i in `cat $TMP1`
do
ls -al /home/$i | egrep '(.profile|.kshrc|.cshrc|.login|.exrc|.netrc|.bashrc|.bash_profile|.bash_logout)' | awk '{print $3}' > $TMP2
ls -al /home/$i | egrep '(.profile|.kshrc|.cshrc|.login|.exrc|.netrc|.bashrc|.bash_profile|.bash_logout)' | awk '{print $1}' > $TMP3
for j in `cat $TMP2`
do
case $j in
$i) : ;;
root) : ;;
*)
WARN 환경변수의 소유자가 다른 계정으로 지정되어 있습니다.
INFO /home/$i 의 환경파일을 확인하십시오.
TRUEFALSE=0 ;;
esac
done
for k in `cat $TMP3`
do
if [ $k != "-rw-r--r--." ] ; then
WARN 환경변수 파일에 root와 소유자 외에 쓰기 또는 실행 권한이 부여되어 있습니다
INFO /home/$i 의 환경파일을 확인하십시오.
TRUEFALSE=0
fi
done
done

if [ $TRUEFALSE -eq 1 ] ; then
OK 환경변수의 소유자 설정과 권한 설정이 양호합니다.
fi

cat $RESULT
echo; echo
