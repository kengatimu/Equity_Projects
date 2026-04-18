#################################################################################
# Source Name               : stopchq.com 
# Date                      : 09-12-2013
# Description               : unverified stopped Chq
# Author                    : Bharath
##################################################################################
. `execom commfunc.com`
input="$1"
reportFileName="stopchq${$}.rpt"
ripFileName="stopchq${$}.rip"
mrtFileName="stopchq.mrt"

exebatch bauu9151 $TBA_PROD_ROOT/cust/sql/stopchq.sql "$1" "$2"
if [ $? -ne 0 ]
then
    echo "SQL procedure execution failed for hotce Report !"
    exit 1
fi

exebatch mrbx4004 $B2K_SESSION_ID $mrtFileName stopchq.lst $reportFileName 

if [ $? -ne 0 ]
then
   echo "Report Generation Failed !"
  exit 2
else
	echo "Report generated. To See/Print the report go to BackGround Menu ."
fi

noOfPages=`grep -c "^L" "$reportFileName"`
noOfPages=`expr "${noOfPages}" + 1`
exebatch babx4040 "${B2K_SESSION_ID}" "$reportFileName.rpt" "Unverified Stopped Chq  " "MANAGER" "${noOfPages}" N

if [ "x$TBA_DEBUG" = "x" ] 
then
    rm -f $lstFileName
    rm -f $datFileName
    rm -f $ripFileName
fi

exit 0
