input1="$1"
input2="$2"
reportFileName="erpmovementsol${$}"
ripFileName="erpmovementsol${$}.rip"

bauu9151 erpmovementsol.sql "$1" "$2"
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
