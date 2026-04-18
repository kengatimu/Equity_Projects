input1="$1"
input2="$2"
input3="$3"
input4="$4"
reportFileName="fcases${$}"
ripFileName="fcases${$}.rip"

bauu9151 fcases.sql "$1" "$2" "$3" "$4"
if [ $? -ne 0 ]
then
    echo "SQL procedure execution failed for Trading Report !"
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
