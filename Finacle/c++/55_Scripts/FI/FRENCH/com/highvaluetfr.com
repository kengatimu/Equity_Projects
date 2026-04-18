#------------------------------------------------------------------------------------------------------------------    
#	Name			: highvaluetfr.com
#	Description		: It will generate a report in HPR 
#	Date			: 28-05-2019
#	Author			: Kim Mugambi
#	Input			: NA
#	Output			: NA
#	Srl. No			Date			Author			Description.   
#	-------			---------		-------			---------------			
#	1.0			28-05-2019		Kim Mugambi		Original Version
#--------------------------------------------------------------------------------------------------------------------
#. `execom commfunc.com`
input="$1"
input1="$2"
reportFileName="highvaluetfr${$}"
ripFileName="highvaluetfr${$}.rip"
mrtFileName="highvaluetfr.mrt"
#exebatch bauu9151 $TBA_PROD_ROOT/cust/01/INFENG/sql/highvaluetfr.sql "$1"
bauu9151 highvaluetfr.sql "$1" "$2"
if [ $? -ne 0 ]
then
    echo "SQL procedure execution failed for highvaluetfr Report !"
	sleep 10
    exit 1
fi

 mrbx4004 $B2K_SESSION_ID  $mrtFileName highvaluetfr.lst $reportFileName 

if [ $? -ne 0 ]
then
   echo "Report Generation Failed !"
  exit 2
else
	echo "Report generated. To See/Print the report go to BackGround Menu ."
fi

noOfPages=`grep -c "^L" "$reportFileName"`
noOfPages=`expr "${noOfPages}" + 1`
babx4040 "${B2K_SESSION_ID}" "$reportFileName.rpt" "Unverified High Value Account Transfer" "MANAGER" "${noOfPages}" N

if [ "x$TBA_DEBUG" = "x" ] 
then
    rm -f $lstFileName
    rm -f $datFileName
    rm -f $ripFileName
fi

exit 0
