#------------------------------------------------------------------------------------------------------------------    
#	Name			: highvaluetfr2.com
#	Description		: It will generate a report in HPR 
#	Date			: 02-06-2020
#	Author			: Irungu James
#	Input			: NA
#	Output			: NA
#	Srl. No			Date			Author			Description.   
#	-------			---------		-------			---------------			
#	1.0			02-06-2020		Irungu James		Original Version
#--------------------------------------------------------------------------------------------------------------------
#. `execom commfunc.com`
input="$1"
input1="$2"
input2="$3"
reportFileName="highvaluetfr2${$}"
ripFileName="highvaluetfr2${$}.rip"
mrtFileName="highvaluetfr2.mrt"
#exebatch bauu9151 $TBA_PROD_ROOT/cust/01/INFENG/sql/highvaluetfr2.sql "$1"
bauu9151 highvaluetfr2.sql "$1" "$2" "$3"
if [ $? -ne 0 ]
then
    echo "SQL procedure execution failed for highvaluetfr2 Report !"
	sleep 10
    exit 1
fi

 mrbx4004 $B2K_SESSION_ID  $mrtFileName highvaluetfr2.lst $reportFileName 

if [ $? -ne 0 ]
then
   echo "Report Generation Failed !"
  exit 2
else
	echo "Report generated. To See/Print the report go to BackGround Menu ."
fi

noOfPages=`grep -c "^L" "$reportFileName"`
noOfPages=`expr "${noOfPages}" + 1`
babx4040 "${B2K_SESSION_ID}" "$reportFileName.rpt" "Unverified High Value A/c Pending SB199/CA299 Transfer" "MANAGER" "${noOfPages}" N

if [ "x$TBA_DEBUG" = "x" ] 
then
    rm -f $lstFileName
    rm -f $datFileName
    rm -f $ripFileName
fi

exit 0
