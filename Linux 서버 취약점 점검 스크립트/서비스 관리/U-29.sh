#!/bin/bash
. ../function.sh

BAR
CODE [U-29] tftp, talk 서비스 비활성화
cat << EOF >> $RESULT
[ 양호 ] : tftp, talk, ntalk 서비스가 비활성화 되어 있는 경우
[ 취약 ] : tftp, talk, ntalk 서비스가 활성화 되어 있는 경우
EOF
BAR

cat << EOF >> Service_List
/etc/xinetd.d/tftp
/etc/xinetd.d/talk
/etc/xinetd.d/ntalk
EOF

cat Service_List | while read FILE
do
	SERVICE=`echo $FILE | awk -F/ '{print $3}'`
	if [ -f $FILE ]; then
		DISABLE=`cat $FILE | grep disable | awk '{print $3}'`
		if [ $DISABLE = 'yes' ]; then
			OK $SERVICE 서비스가 비활성화 되어 있습니다.
		else
			WARN $SERVICE 서비스가 활성화 되어 있습니다.
		fi
	else
		OK $SERVICE 서비스가 존재하지 않습니다.
	fi
done

rm Service_List

cat $RESULT
echo; echo
