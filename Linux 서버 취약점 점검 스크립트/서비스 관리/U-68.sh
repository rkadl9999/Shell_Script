#!/bin/bash
. ../function.sh

BAR
CODE [U-68] 로그온 시 경고 메시지 제공
cat << EOF >> $RESULT
[ 양호 ] : 서버 및 Telnet, FTP, SMTP, DNS 서비스에 로그온 메시지가 설정되어 있는 경우
[ 취약 ] : 서버 및 Telnet, FTP, SMTP, DNS 서비스에 로그온 메시지가 설정되어 있지 않은 경우
EOF
BAR

SERVER=`cat /etc/motd`
TELNET=`cat /etc/issue.net`
FTP=`cat /etc/vsftpd/vsftpd.conf | grep ftpd_banner | awk -F= '{print $2}'`
SMTP=`cat /etc/mail/sendmail.cf | grep GreetingMessage | awk -F= '{print $2}'`
DNS=`cat /etc/named.conf | grep banner`

if [ -n "$SERVER" ] && [ -n "$TELNET" ] && [ -n "$FTP" ] && [ -n "$SMTP" ] && [ -n "$DNS" ]; then
	OK 서버 및 Telnet, FTP, SMTP, DNS 서비스에 로그온 메시지가 설정되어 있는 경우입니다.
else
	WARN 서버 및 Telnet, FTP, SMTP, DNS 서비스에 로그온 메시지가 설정되어 있지 않은 경우입니다.
fi

cat $RESULT
echo; echo
