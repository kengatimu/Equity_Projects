#------------------------------------------------------------------------------------------------------------------    
#	Name			: MassAcct.com
#	Description		: It will Delete and backup duplicate address
#	Date			: 04-06-2021
#	Author			: Irungu James
#	Input			: NA
#	Output			: NA
#	Srl. No			Date			Author			Description.   
#	-------			---------		-------			---------------			
#	1.0			04-06-2021		Irungu James		Original Version
#--------------------------------------------------------------------------------------------------------------------
#. `execom commfunc.com`
 input="$1"
 input1="$2"
reportFileName="MassAcctFail${$}"
ripFileName="MassAcctFail${$}.rip"
mrtFileName="MassAcctFail.mrt"

bauu9151 MassAcctFail.sql "$1" "$2"
if [ $? -ne 0 ]
then
    echo "SQL procedure execution failed for images Report !"
        sleep 10
    exit 1
fi

mrbx4004 $B2K_SESSION_ID  $mrtFileName MassAcctFail.lst $reportFileName

if [ $? -ne 0 ]
then
   echo "Report Generation Failed !"
  exit 2
else
        echo "Report generated. To See/Print the report go to BackGround Menu ."
fi

noOfPages=`grep -c "^L" "$reportFileName"`
noOfPages=`expr "${noOfPages}" + 1`
babx4040 "${B2K_SESSION_ID}" "$reportFileName.rpt" "Failed Mass Accounts  " "MANAGER" "${noOfPages}" N

if [ "x$TBA_DEBUG" = "x" ]
then
    rm -f $lstFileName
    rm -f $datFileName
    rm -f $ripFileName
fi

