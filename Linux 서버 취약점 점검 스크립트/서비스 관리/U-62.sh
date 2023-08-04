#!/bin/bash
. ../function.sh

BAR
CODE [U-62] ftp 계정 shell 제한
cat << EOF >> $RESULT
[ 양호 ] : ftp 계정에 /bin/false 쉘이 부여되어 있는 경우
[ 취약 ] : ftp 계정에 /bin/false 쉘이 부여되어 있지 않은 경우
EOF
BAR

CHECK=`cat /etc/passwd | grep ftp | awk -F: '{print $7}'`

if [ "$CHECK" = "/bin/false" ]; then
	OK ftp 계정에 /bin/false 쉘이 부여되어 있습니다.
else
	WARN ftp 계정에 /bin/false 쉘이 부여되어 있지 않습니다.
fi

cat $RESULT
echo; echo
