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
