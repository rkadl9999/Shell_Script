#!/bin/bash
. ../function.sh

BAR
CODE [U-41] 웹 서비스 영역의 분리
cat << EOF >> $RESULT
[ 양호 ] : DocumentRoot를 별도의 디렉토리로 지정한 경우
[ 취약 ] : DocumentRoot를 기본 디렉토리로 지정한 경우
EOF
BAR

SERVICE=httpd
STATUS=$(CheckStatus $SERVICE)

if [ -z "$STATUS" ]; then
	OK Apache 서비스를 사용하지 않습니다.
else
	INFO Apache 서비스를 사용하고 있습니다.
	TrueFalse="TRUE"
	CHECK=$(cat /etc/httpd/conf/httpd.conf | grep DocumentRoot | grep -v "#" | awk -F'"' '{print $2}')
	
	DefaultDir=("/var/www/html" "/usr/local/apache/htdocs" "/usr/local/apache2/htdocs")

	for Dir in "${DefaultDir[@]}";
	do
		if [ "$CHECK" = "$Dir" ]; then
			TrueFalse="FALSE"
			break;
		fi
	done

	if [ "$TrueFalse" = "FALSE" ]; then
		WARN DocumentRoot를 별도의 디렉토리로 지정하지 않은 경우입니다.
	else
		OK DocumentRoot를 별도의 디렉토리로 지정한 경우입니다.
	fi
fi

cat $RESULT
echo; echo
