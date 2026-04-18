#----------------------------------------------------------------------------------------- 
#       Author                  : Shishira 
#       Date                    : 11-03-2013
#       com Name                : oclgirptdp001.com
#       Input Parameters        : Sol Id,
#       Purpose Of this File    : 
#       Modification History    :
#       <Serial No.>      <Date>           <Author Name>           <Description>
#        	0.01       28-02-2012		Shishira  		Original 
#----------------------------------------------------------------------------------------

#----------------------------------------------------------------------------------------
#       MAIN SCRIPT
#----------------------------------------------------------------------------------------
	Report="Outward inhouse Clrg File"
	SqlFile=oclgirpt.sql
	LstFile="oclgirpt_$$.TXT"
	logfile="oclgirpt.log"
	reportFileName="oclg_$1_$2.rpt"
	solId=$1
	zoneDate=$2
	zoneCode=$3
	bankId=$4
	pZoneCode1=$5
	pZoneCode2=$6
	pZoneCode3=$7
#----------------------------------------------------------------------------------------
#       SQL Execution
#----------------------------------------------------------------------------------------
#	exebatch spbx4001 CUSTOM.OCLGIRPT_PACK.OCLGIRPT_PROC $solId $zoneDate $zoneCode $bankId $pZoneCode1 $pZoneCode2 > $LstFile
	spbx4001 CUSTOM.OCLGIRPT_PACK_UG.OCLGIRPT_PROC_UG $solId $zoneDate $zoneCode $bankId $pZoneCode1 $pZoneCode2 > $LstFile 
	if [ $? -ne 0 ]
	then
		echo "SQL execution failed !"
		exit 0
	fi
cat $LstFile > $reportFileName
#----------------------------------------------------------------------------------------
#Setting the path for file 
#----------------------------------------------------------------------------------------
	RptFile=/$LstFile
#----------------------------------------------------------------------------------------
#Pushing The Report To Backround Menu
#----------------------------------------------------------------------------------------
noOfPages=`grep -c "^L" "$reportFileName"`
noOfPages=`expr "${noOfPages}" + 1` 

#exebatch babx4040 ${B2K_SESSION_ID} $reportFileName "$Report" "MANAGER" "$noOfPages" "N"
babx4040 ${B2K_SESSION_ID} $reportFileName "$Report" "MANAGER" "$noOfPages" "N"
		if [ $? -ne 0 ]
		then
			echo "Report Generated. To View/Print, Use HPR Menu." >>$logfile
		fi
rm -f $LstFile *lst *LST 
exit 0
