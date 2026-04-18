#------------------------------------------------------------------------------------------------------------------    
#	Name			: unzerocashgls.com
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
input2="$3"
input3="$4"
input4="$5"
input5="$6"
input6="$7"
input7="$8"
input8="$9"
reportFileName="unzerocashgls${$}"
ripFileName="unzerocashgls${$}.rip"
mrtFileName="unzerocashgls.mrt"
echo "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9" > un1.lst

bauu9151 unzerocashgls.sql "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9"
if [ $? -ne 0 ]
then
    echo "SQL procedure execution failed for unzerocashgls Report !"
	sleep 10
    exit 1
fi
echo "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9" > un2.lst

mrbx4004 $B2K_SESSION_ID $mrtFileName unzerocashgls.lst $reportFileName 

if [ $? -ne 0 ]
then
   echo "Report Generation Failed !"
  exit 2
else
	echo "Report generated. To See/Print the report go to BackGround Menu ."
fi

noOfPages=`grep -c "^L" "$reportFileName"`
noOfPages=`expr "${noOfPages}" + 1`
babx4040 "${B2K_SESSION_ID}" "$reportFileName.rpt" "Unzerorised  CASH GLS report " "MANAGER" "${noOfPages}" N

if [ "x$TBA_DEBUG" = "x" ] 
then
    rm -f $lstFileName
    rm -f $datFileName
    rm -f $ripFileName
fi

exit 0
