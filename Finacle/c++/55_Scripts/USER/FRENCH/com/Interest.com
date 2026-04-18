#------------------------------------------------------------------------------------------------------------------    
#	Name			: Interest.com
#	Description		: It will generate a report in HPR 
#	Date			: 19.05.2017
#	Author			: Kim Mugambi
#	Input			: NA
#	Output			: NA
#	Srl. No			Date			Author			Description.   
#	-------			---------		-------			---------------			
#	1.0		        19.05.2017		Kim Mugambi	        Original Version
#--------------------------------------------------------------------------------------------------------------------
#. `execom commfunc.com`
input="$1"
input1="$2"
reportFileName="Interest${$}"
ripFileName="Interest${$}.rip"
mrtFileName="Interest.mrt"
#exebatch bauu9151 $TBA_PROD_ROOT/cust/01/INFENG/sql/Interest.sql "$1"
bauu9151 Interest.sql "$1" "$2"
if [ $? -ne 0 ]
then
    echo "SQL procedure execution failed for Interest Report !"
	sleep 10
    exit 1
fi

 mrbx4004 $B2K_SESSION_ID  $mrtFileName Interest.lst $reportFileName 

if [ $? -ne 0 ]
then
   echo "Report Generation Failed !"
  exit 2
else
	echo "Report generated. To See/Print the report go to BackGround Menu ."
fi

noOfPages=`grep -c "^L" "$reportFileName"`
noOfPages=`expr "${noOfPages}" + 1`
babx4040 "${B2K_SESSION_ID}" "$reportFileName.rpt" "Unverified Account Interest Rate Modification(s)" "MANAGER" "${noOfPages}" N

if [ "x$TBA_DEBUG" = "x" ] 
then
    rm -f $lstFileName
    rm -f $datFileName
    rm -f $ripFileName
fi

exit 0
