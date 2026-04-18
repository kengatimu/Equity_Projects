input1="$1"
input2="$2"
input3="$3"
input4="$4"
reportFileName="dailymv_adhoc${$}"
ripFileName="dailymv_adhoc${$}.rip"

bauu9151 dailymv_adhoc.sql "$1" "$2" "$3" "$4"
if [ $? -ne 0 ]
then
    echo "SQL procedure execution failed for adhoc Report !"
	sleep 10
    exit 1
fi

if [ "x$TBA_DEBUG" = "x" ] 
then
    rm -f $lstFileName
    rm -f $datFileName
    rm -f $ripFileName
fi

exit 0
