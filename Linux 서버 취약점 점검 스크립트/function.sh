LOG=check.log
RESULT=result.log
> $LOG
> $RESULT

BAR() {
echo "=============================================================================" >> $RESULT
}

NOTICE() {
echo '[ OK ] : 정상'
echo '[ WARN ] : 비정상'
echo '[ INFO ] : Information 파일 확인'
}

OK() {
echo -e '\033[32m'"[ 양호 ] : $*"'\033[0m'
} >> $RESULT

WARN() {
echo -e '\033[31m'"[ 취약 ] : $*"'\033[0m'
} >> $RESULT

INFO() {
echo -e '\033[35m'"[ 정보 ] : $*"'\033[0m'
} >> $RESULT

CODE() {
echo -e '\033[36m'$*'\033[0m'
} >> $RESULT

SCRIPTNAME() {
basename $0 | awk -F. '{print $1}'
}

FindPatternReturnValue() {
if egrep -v '^#|^$' $1 | grep -q $2 ; then
	ReturnValue=$(egrep -v '^#|^$' $1 | grep $2 | awk -F= '{print $2}')
else
	ReturnValue=None
fi
echo $ReturnValue
}

IsFindPattern() {
if egrep -v '^#|^$' $1 | grep -q $2 ; then
	ReturnValue=$?
else
	ReturnValue=$?
fi
echo $ReturnValue
}

PAM_FindPatternReturnValue() {
PAM_FILE=$1
PAM_MODULE=$2
PAM_FindPattern=$3
LINE=$(egrep -v '^#|^$' $PAM_FILE | grep $PAM_MODULE)
if [ -z "$LINE" ] ; then
	ReturnValue=None
else
	PARAMS=$(echo $LINE | cut -d ' ' -f4-)
	set $PARAMS
	while [ $# -ge 1 ]
	do
		CHOICE1=$(echo $* | awk '{print $1}' | awk -F= '{print $1}')
		CHOICE2=$(echo $* | awk '{print $1}' | awk -F= '{print $2}')
		case $CHOICE1 in
			$PAM_FindPattern) ReturnValue=$CHOICE2 ;;
			*) : ;;
		esac
		shift
	done
fi
echo $ReturnValue
}

CheckEncryptedPasswd() {
$FILE=$1
EncryptedPasswdField=$(grep '^root' $FILE | awk -F: '{print $2}' | awk -F'$' '{print $2}')
case $EncryptedPasswdField in
	1|2a|5) echo WarnTrue ;;
	6) echo TrueTrue ;;
	*) echo 'None' ;;
esac
}

SearchValue() {
SEARCH=$(egrep -v '^#|^$' $2 | sed 's/#.*//' | grep -w $3)
if [ -z "$SEARCH" ] ; then
	echo FALSE
else
	if [ $1 = 'KEYVALUE' ] ; then
	echo $SEARCH
elif [ $1 = 'VALUE' ] ; then
	echo "$SEARCH" | awk '{print $2}'
	fi
fi
}
