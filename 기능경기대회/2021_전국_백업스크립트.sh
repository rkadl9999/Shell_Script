#!/bin/bash

time=`date "+%m-%d-%H-%M"`

`tar -cvzf /backup/$time-etclog.tar.gz /var/log/* /etc 2> /dev/null`
