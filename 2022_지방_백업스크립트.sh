#/bin/sh
time=`date "+%Y-%m-%d-%H:%M:%S"`; #시간 포맷 설정

`mkdir /backup 2> /dev/null`; #/backup 디렉토리 생성 , 표준 오류는 출력 X
`tar -g /var/log/* -zcvf /backup/$time-log.tar.gz`; #시간-log.tar.gz 형식으로 압축
