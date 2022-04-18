#!/bin/sh
echo "
*****************************************************************
                시스템 취약점 점검을 시작합니다.
*****************************************************************
";

echo "시작 시간 : `date`\n\n";

passwd_ch=`ls -l /etc/passwd | awk {'print $1'} | cut -c 8-`;
route_ch=`cat /proc/sys/net/ipv4/ip_forward`;

echo "01. /etc/passwd 파일 권한 점검\n\n";

if [ "${passwd_ch}" = "r--" ]; then
    echo "[양호] 현재 권한 : `ls -l /etc/passwd | awk {'print $1'}`\n\n";
else
    echo "[취약] 현재 권한 : `ls -l /etc/passwd | awk {'print $1'}`\n\n";
fi

echo "02. 라우팅 활성화 여부 점검\n\n";

if [ "${route_ch}" = "0" ]; then
    echo "[양호] 라우팅 비활성화\n\n";
else
    echo "[취약] 라우팅 활성화\n\n";
fi

echo "03. SetUID, SetGID, Sticky bit 권한이 설정된 파일을 검색 후 /root/files.txt에 저장\n\n";

setuid=`find / -perm -4000 2> /dev/null > /root/files.txt`;
setgid=`find / -perm -2000 2> /dev/null >> /root/files.txt`;
Sticky=`find / -perm -1000 2> /dev/null >> /root/files.txt`;