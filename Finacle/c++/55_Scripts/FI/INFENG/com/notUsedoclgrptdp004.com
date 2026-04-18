#----------------------------------------------------------------------------------------- 
#       Author                  : Shishira 
#       Date                    : 11-03-2013
#       com Name                : oclgrptdp004.com
#       Input Parameters        : Sol Id,zoneDate,zoneCode,bankId,pZoneCode1,pZoneCode2,pZoneCode3
#       Purpose Of this File    : 
#       Modification History    :
#       <Serial No.>      <Date>           <Author Name>           <Description>
#        	0.01       28-02-2012		Shishira  		Original 
#----------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------
#       MAIN SCRIPT
#----------------------------------------------------------------------------------------
        Report="Outward Clearing File"
        SqlFile=oclgrptRD.sql
        LstFile="oclgrpt_$$.TXT"
        reportFileName="oclgbcqs_$1_$2.rpt"
        logfile="oclgrpt.log"
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
#	exebatch spbx4001 CUSTOM.OCLGRPT_PACK_05.OCLGRPT_PROC_05 $solId!$zoneDate!$zoneCode!$bankId!$pZoneCode1!$pZoneCode2!$pZoneCode3> $LstFile
	spbx4001 CUSTOM.OCLGRPT_PACK_05.OCLGRPT_PROC_05 $solId!$zoneDate!$zoneCode!$bankId!$pZoneCode1!$pZoneCode2!$pZoneCode3> $LstFile 
	if [ $? -ne 0 ]
	then
		echo "SQL execution failed !"
		exit 0
	fi
#----------------------------------------------------------------------------------------
#Setting the path for file 
#----------------------------------------------------------------------------------------
	RptFile=/$LstFile

cat $LstFile>$reportFileName
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

    rm -f $LstFile
exit 0
