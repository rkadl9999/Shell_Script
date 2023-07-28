#!/bin/bash

while true
do
        echo
        echo "Check Time : `date`"
        echo

        APACHE=`systemctl status apache2 | grep Active | awk '{print $2}'`
        SSH=`systemctl status sshd | grep Active | awk '{print $2}'`
        if [ $APACHE = "active" ]; then
                echo "[GOOD] Apache is Running..."
        else
                echo "[BAD] Apache is inactive"
                echo "Apache Start..."
                `systemctl start apache2`
        fi

        if [ $SSH = "active" ]; then
                echo "[GOOD] SSH is Running..."
        else
                echo "[BAD] SSH is inactive"
                echo "SSH Start..."
                `systemctl start sshd`
        fi

        sleep 30
done
