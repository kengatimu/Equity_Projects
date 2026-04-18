#------------------------------------------------------------------------------------------------------------------    
#	Name			: unzerogl.com
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
set -x
input="$1"
input1="$2"
input2="$3"
reportFileName="unzerogl${$}"
ripFileName="unzerogl${$}.rip"
mrtFileName="unzerogl.mrt"

bauu9151 unzerogl.sql "$1" "$2" "$3"
if [ $? -ne 0 ]
then
    echo "SQL procedure execution failed for unzerogl Report !"
	sleep 10
    exit 1
fi

mrbx4004 $B2K_SESSION_ID $mrtFileName unzerogl.lst $reportFileName 

if [ $? -ne 0 ]
then
   echo "Report Generation Failed !"
  exit 2
else
	echo "Report generated. To See/Print the report go to BackGround Menu ."
fi

noOfPages=`grep -c "^L" "$reportFileName"`
noOfPages=`expr "${noOfPages}" + 1`
babx4040 "${B2K_SESSION_ID}" "$reportFileName.rpt" "Unzerorised GLS report " "MANAGER" "${noOfPages}" N

if [ "x$TBA_DEBUG" = "x" ] 
then
    rm -f $lstFileName
    rm -f $datFileName
    rm -f $ripFileName
fi

exit 0
