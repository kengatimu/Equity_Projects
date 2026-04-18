input1="$1"
input2="$2"
reportFileName="cbk_accounts_dataSpL01${$}"
ripFileName="cbk_accounts_dataSpL01${$}.rip"

bauu9151 cbk_accounts_dataSpL01.sql "$1" "$2"
if [ $? -ne 0 ]
then
    echo "SQL procedure execution failed for erp report Report !"
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
