#------------------------------------------------------------------------------------------------------------------    
#	Name			: payoff.com
#	Description		: It will generate a report in HPR 
#	Date			: 03-10-2016
#	Author			: KIM MUGAMBI
#	Input			: NA
#	Output			: NA
#	Srl. No			Date			Author			Description.   
#	-------			---------		-------			---------------			
#	1.0			03-10-2016	KIM MUGAMBI			Original Version
#--------------------------------------------------------------------------------------------------------------------
#. `execom commfunc.com`
input="$1"
input1="$2"
reportFileName="payoff${$}"
ripFileName="payoff${$}.rip"
mrtFileName="payoff.mrt"
#exebatch bauu9151 $TBA_PROD_ROOT/cust/01/INFENG/sql/payoff.sql "$1"
bauu9151 payoff.sql "$1" "$2"
if [ $? -ne 0 ]
then
    echo "SQL procedure execution failed for payoff Report !"
	sleep 10
    exit 1
fi

 mrbx4004 $B2K_SESSION_ID  $mrtFileName payoff.lst $reportFileName 

if [ $? -ne 0 ]
then
   echo "Report Generation Failed !"
  exit 2
else
	echo "Report generated. To See/Print the report go to BackGround Menu ."
fi

noOfPages=`grep -c "^L" "$reportFileName"`
noOfPages=`expr "${noOfPages}" + 1`
babx4040 "${B2K_SESSION_ID}" "$reportFileName.rpt" "Unverified Payoff/Hlaspay Account exist" "MANAGER" "${noOfPages}" N

if [ "x$TBA_DEBUG" = "x" ] 
then
    rm -f $lstFileName
    rm -f $datFileName
    rm -f $ripFileName
fi

exit 0
