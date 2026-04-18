#------------------------------------------------------------------------------------------------------------------    
#	Name			: trans.com
#	Description		: It will generate a report in HPR 
#	Date			: 12-02-2013
#	Author			: GOKULKRISHNA
#	Input			: NA
#	Output			: NA
#	Srl. No			Date			Author			Description.   
#	-------			---------		-------			---------------			
#	1.0				12-02-2013		GOKULKRISHNA			Original Version
#--------------------------------------------------------------------------------------------------------------------
#. `execom commfunc.com`
input="$1"
input1="$2"
reportFileName="trans${$}"
ripFileName="trans${$}.rip"
mrtFileName="trans.mrt"

bauu9151 trans.sql "$1" "$2"
if [ $? -ne 0 ]
then
    echo "SQL procedure execution failed for trans Report !"
	sleep 10
    exit 1
fi

mrbx4004 $B2K_SESSION_ID $mrtFileName tran.lst $reportFileName 

if [ $? -ne 0 ]
then
   echo "Report Generation Failed !"
  exit 2
else
	echo "Report generated. To See/Print the report go to BackGround Menu ."
fi

noOfPages=`grep -c "^L" "$reportFileName"`
noOfPages=`expr "${noOfPages}" + 1`
babx4040 "${B2K_SESSION_ID}" "$reportFileName.rpt" "Unverified transfered accounts  " "MANAGER" "${noOfPages}" N

if [ "x$TBA_DEBUG" = "x" ] 
then
    rm -f $lstFileName
    rm -f $datFileName
    rm -f $ripFileName
fi

exit 0
