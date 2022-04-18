#/bin/sh
time=`date "+%Y-%m-%d-%H:%M:%S"`;

`mkdir /backup 2> /dev/null`;
`tar -g /var/log/* -zcvf /backup/$time-log.tar.gz`;